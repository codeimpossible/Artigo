module Artigo
	CONFIG_FILE = "#{::Rails.root.to_s}/config/artigo.yml"

	class Configuration < Array
		def initialize
			self << YAML.load_file(Artigo::CONFIG_FILE) if File.exist?(Artigo::CONFIG_FILE)
		end
	end

	CONFIG = Artigo::Configuration.new

	def self.theme_dir
		"/themes/#{Artigo.get_conf('app_theme')}"
	end
	
	def self.commit_reload(yaml = nil)
		unless yaml.nil?
			File.new(Artigo::CONFIG_FILE, "w") unless File.exist?(Artigo::CONFIG_FILE)
			File.open(Artigo::CONFIG_FILE, "w") do |f|
				f.write(yaml)
			end			
		else
			yaml = Artigo::CONFIG.first.to_yaml
		end

		Artigo::CONFIG[0] = YAML.load(yaml) #gets around the ruby warning for assigning to an existing constant
											#this still feels dirty and finding a better method for storing and
											#retrieving configuration values should be a high priority for the next
											#release
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
	end
end
