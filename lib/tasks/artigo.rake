namespace :artigo do
	desc 'Generates a session_store.rb file.'
	task :generate_session_store => :environment do
		path = File.join(::Rails.root.to_s, 'config', 'initializers', 'session_store.rb')
		secret = ActiveSupport::SecureRandom.hex(40)
		File.new(path, "w") unless File.exist?(path)
		File.open(path, "w") do |f|
			f.write <<"EOF"
# Be sure to restart your server when you modify this file.

Artigo::Application.config.session_store :cookie_store, :key => '_artigo_session'
Artigo::Application.config.secret_token = '#{secret}'
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Artigo::Application.config.session_store :active_record_store
EOF
		end
	end
	
	desc 'Generates a site_keys.rb file.'
	task :generate_site_keys => :environment do
		path = File.join(::Rails.root.to_s, 'config', 'initializers', 'site_keys.rb')
		secret = ActiveSupport::SecureRandom.hex(40)
		File.new(path, "w") unless File.exist?(path)
		File.open(path, "w") do |f|
			f.write <<"EOF"
# This file should not be made visible to public.
REST_AUTH_SITE_KEY         = '#{secret}'
REST_AUTH_DIGEST_STRETCHES = 10
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
head_title: 
- "My Artigo Blog"
site_title: 
- "My Artigo Blog"
posts_per_page: 
- "3"
app_theme:
- "k2"
disqus_account:
- "artigo"
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
	task :first_time => [:generate_session_store, :generate_site_keys, :make_config, :make_db_config, :db]
end
