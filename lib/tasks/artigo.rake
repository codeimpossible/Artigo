namespace :artigo do
	desc 'Generates a session_store.rb file.'
	task :generate_session_store => :environment do
		path = File.join(RAILS_ROOT, 'config', 'initializers', 'session_store.rb')
		secret = ActiveSupport::SecureRandom.hex(40)
		File.new(path, "w") unless File.exist?(path)
		File.open(path, "w") do |f|
			f.write <<"EOF"
# This file should not be made visible to public.
ActionController::Base.session = {
  :session_key => '_artigo_session',
  :secret => '#{secret}'
}
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
    
	desc 'Initializes Artigo Security Settings'
	task :setup => [:generate_session_store, :generate_site_keys, :make_db_config]
end