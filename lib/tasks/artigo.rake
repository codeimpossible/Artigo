namespace :artigo do
	desc 'Generates a session_store.rb file.'
	task :generate_session_store => :environment do
		path = File.join(RAILS_ROOT, 'config', 'initializers', 'session_store.rb')
		File.new(path, "w") unless File.exist?(path)
		File.open(path, "w") do |f|
			f.write <<"EOF"
# Be sure to restart your server when you modify this file.

Artigo::Application.config.session_store :cookie_store, :key => '_artigo_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Artigo::Application.config.session_store :active_record_store
EOF
		end
	end
	
	desc 'Generates a site_keys.rb file.'
	task :generate_site_keys => :environment do
		path = File.join(RAILS_ROOT, 'config', 'initializers', 'site_keys.rb')
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
	
    desc 'Creates a base database.yml file'
    task :make_db_config do
        path = File.join(RAILS_ROOT, 'config', 'database.yml')
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
    task :db => ['environment', 'db:drop', 'db:create', 'db:migrate', 'db:fixtures:load' ] do
        (1..60).each { |n|
            @post = Post.create({ 
                :published => true,
                :title => "This is the #{n} sample post",
                :summary => "The description should be 2-3 sentences and grab your readers' attention. The ending should act as an introduction into your main body.",
                :body => <<eos 
    <p>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo. This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</p>
    <p>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</p>
    <blockquote>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</blockquote>
    <p>This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo. This is an example of a artigo page, you could edit this to put information about yourself or your site so readers know where you are coming from. You can create as many pages like this one or sub-pages as you like and manage all of your content inside of artigo.</p>
    <p>Here are some of my favorite movies</p>
    <ul>
        <li>Hi Fidelity</li>
        <li>American President</li>
        <li>Americas Sweethearts</li>
        <li>Die Hard</li>
        <li>L.A. Confidential</li>
    </ul>
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
        }
    end
    
	desc 'Initializes Artigo Security Settings'
	task :setup => [:generate_session_store, :generate_site_keys, :make_db_config, :db]
end
