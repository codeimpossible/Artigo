module Artigo
	CONFIG_FILE = Rails.env == "test" ?
		"#{Rails.root}/test/artigo_config.yml" : 
		"#{Rails.root}/config/artigo.yml"

	class Configuration < Array
		def initialize
			self << YAML.load_file(Artigo::CONFIG_FILE) if File.exist?(Artigo::CONFIG_FILE)
		end

		def write
			yaml = Artigo::CONFIG.first.to_yaml
			File.new(Artigo::CONFIG_FILE, "w") unless File.exist?(Artigo::CONFIG_FILE)
			File.open(Artigo::CONFIG_FILE, "w") do |f|
				f.write(yaml)
			end	
		end
	end

	CONFIG = Artigo::Configuration.new

	def self.theme_dir
		"/themes/#{Artigo.get_conf('app_theme')}"
	end

	def self.has_conf(name)
		Artigo::CONFIG.first.has_key? name
	end

	def self.get_conf(name)
		@result = ""
		@result = Artigo::CONFIG.first[name] if Artigo::CONFIG.first[name]
	end

	def self.set_conf(name, value)
		Artigo::CONFIG.first[name] = value
		Artigo::CONFIG.write
	end
end
