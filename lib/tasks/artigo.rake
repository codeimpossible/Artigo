require 'digest/sha1'

SECRET = ActiveSupport::SecureRandom.hex(40)

def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
end
def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
end
def password_digest(password, salt)
    digest = SECRET
    10.times do
      digest = secure_digest(digest, salt, password, SECRET)
    end
    digest
end

def make_fake_token
    @fake_token_counter ||= 0
    @fake_token_counter +=  1
    Digest::SHA1.hexdigest(@fake_token_counter.to_s)
end
  
namespace :artigo do
	desc 'Generate restauth keys'
	task :generate_keys => :environment do
		session_path = File.join(::Rails.root.to_s, 'config', 'initializers', 'session_store.rb')
		keys_path = File.join(::Rails.root.to_s, 'config', 'initializers', 'site_keys.rb')
		File.new(session_path, "w") unless File.exist?(session_path)
		File.open(session_path, "w") do |f|
			f.write <<"EOF"
# Be sure to restart your server when you modify this file.

Artigo::Application.config.session_store :cookie_store, :key => '_artigo_session'
Artigo::Application.config.secret_token = '#{SECRET}'
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Artigo::Application.config.session_store :active_record_store
EOF
		end

		File.new(keys_path, "w") unless File.exist?(keys_path)
		File.open(keys_path, "w") do |f|
			f.write <<"EOF"
# This file should not be made visible to public.
REST_AUTH_SITE_KEY         = '#{SECRET}'
REST_AUTH_DIGEST_STRETCHES = 10
EOF
		end
	end
	
	desc 'Creates a base user fixture for the Restful Auth plugin'
	task :make_auth_fixture => :generate_keys do
		path 	= File.join(::Rails.root.to_s, 'test', 'fixtures', 'users.yml')
		salts   = (1..2).map{ make_fake_token }
		passwds = salts.map{ |salt| password_digest('monkey', salt) }
		
		File.new(path, "w") unless File.exist?(path)
		File.open(path, "w") do |f|
			f.write << "EOF"
# This file was generated by the artigo rake task "make_auth_fixture"
# Don't change this unless you know what you're doing
# Changing this file will probably brake your tests
quentin: 
  id:                        1
  login:                     quentin
  email:                     quentin@example.com
  salt:                      #{ salts[0] } # SHA1('0')
  crypted_password:          #{ passwds[0] } # 'monkey'
  created_at:                <%= 5.days.ago.to_s :db  %>
  remember_token_expires_at: <%= 1.days.from_now.to_s %>
  remember_token:            #{ make_fake_token }
      
aaron:
  id:                        2
  login:                     aaron
  email:                     aaron@example.com
  salt:                      #{ salts[1] } # SHA1('1')
  crypted_password:          #{ passwds[1] } # 'monkey'
  created_at:                <%= 1.days.ago.to_s :db %>
  remember_token_expires_at: 
  remember_token:            
			
old_password_holder:
  id:                        3
  login:                     old_password_holder
  email:                     salty_dog@example.com
  salt:                      7e3041ebc2fc05a40c60028e2c4901a81035d3cd
  crypted_password:          00742970dc9e6319f8019fd54864d3ea740f04b1 # test
  created_at:                <%= 1.days.ago.to_s :db %>
EOF
		end
	end
	
	desc 'Creates a base artigo.yml file'
	task :make_config do
		path = File.join(::Rails.root.to_s, 'config', 'artigo.yml')
	        File.new(path,"w") unless File.exist?(path)
	        File.open(path, "w") do |f|
        	    f.write <<"EOF"
--- 
app_theme: 
- metro
google_analytics: 
- analyticscode_here
head_title: 
- My Artigo Blog
site_title: 
- My Artigo Blog
disqus_account: 
- artigo
site_description: 
- Just another awesome Artigo Blog
posts_per_page: 
- "3"
EOF
		end
	end
	
    desc 'Creates a base database.yml file'
    task :make_db_config do
        path = File.join(::Rails.root.to_s, 'config', 'database.yml')
        File.new(path,"w") unless File.exist?(path)
        File.open(path, "w") do |f|
            f.write <<"EOF"
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

  #change this before going live
production:
  adapter: sqlite3
  database: db/production.sqlite3
  pool: 5
  timeout: 5000
EOF
        end
    end

    desc 'Initializes and fills the database with default data'
    task :db => ['environment', 'db:reset' ] do	
		@post = Post.create({ 
			:published => true,
			:title => "Sample Post",
			:summary => "This is just a sample blog post. Take a look and use it to test any themes you install.",
			:body => <<eos
<h2>Header 2</h2>
<p>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</p>
<blockquote>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</blockquote>
<h3>Header 3</h3>
<p>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo. This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</p>
<p>Here are some of my favorite movies</p>
<ul>
	<li>Hi Fidelity</li>
	<li>American President</li>
	<li>Americas Sweethearts</li>
	<li>Die Hard</li>
	<li>L.A. Confidential</li>
</ul>
<h4>Header 4</h4>
<p>Here are my favorite movies in an ordered list</p>
<ol>
	<li>Hi Fidelity</li>
	<li>American President</li>
	<li>Americas Sweethearts</li>
	<li>Die Hard</li>
	<li>L.A. Confidential</li>
</ol>
eos
		})
		
		@post = Post.create({ 
			:published => true,
			:title => "Welcome to Artigo, release 1: Die Hard",
			:summary => "This is your first blog post. You can delete this or edit it and start blogging!",
			:body => <<eos
<img src="/images/admin/die-hard.jpg" />
<p>
	Welcome to Artigo release 1, &quot;Die Hard&quot;. Artigo, Portuguese for Article, is a blog platform written in Ruby. Artigo is painstakingly developed by me, Jared Barboza of <a href="http://codeimpossible.com">Codeimpossible.com</a>.</p>
<p>
	I&#39;ve tried to build a very reliable, fast and easy to use bloging software but if you encounter any issues, use the &quot;I found a bug&quot; feature in the <a href="/admin">admin area</a>.</p>
<p>
	Feel free to follow me on any of the sites below: <a href="http://twitter.com/codeimpossible">twitter</a>
</p>
eos
		})
    end
    
	desc 'Artigo First Time Setup'
	task :first_time => [:make_db_config, :make_config, :generate_keys, :make_auth_fixture, :db]
end
