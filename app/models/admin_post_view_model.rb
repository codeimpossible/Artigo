class AdminPostViewModel
	attr_accessor :post, :tags
	
	def initialize(post, tags)
		@post = post
		@tags = tags
	end
end