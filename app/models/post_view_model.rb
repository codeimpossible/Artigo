class PostViewModel
	attr_accessor :posts, :options
	
	def initialize(posts, options)
		@posts = posts
		@options = options
	end
	
	def get_opt(name)
		@result = ""
		@result = @options.where("name = ?", name).first.value if @options.where("name = ?", name).count > 0
	end
end