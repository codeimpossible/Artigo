class ThemedViewModel
	attr_accessor :content, :options
	
	def initialize(content, options)
		@content = content
		@options = options
	end
	
	def get_opt(name)
		@result = ""
		@result = @options.where("name = ?", name).first.value if @options.where("name = ?", name).count > 0
	end
end