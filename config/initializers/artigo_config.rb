module Artigo
	
	@@config_path = "#{::Rails.root.to_s}/config/artigo.yml"
	
	CONFIG = YAML.load_file(@@config_path) if File.exist?(@@config_path)
	
	def self.theme_dir
		"/themes/#{Artigo::CONFIG['app_theme'].first}"
	end
	
	def self.get_conf(name)
		@result = ""
		@result = Artigo::CONFIG[name].first if Artigo::CONFIG[name]
	end
	
	def self.store_config(yaml)
		File.new(@@config_path, "w") unless File.exist?(@@config_path)
		File.open(@@config_path, "w") do |f|
			f.write(yaml)
		end
		Artigo.const_set( "CONFIG", YAML.load(yaml) )
	end
end
