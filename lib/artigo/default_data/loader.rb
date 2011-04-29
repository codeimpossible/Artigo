module Artigo
	module DefaultData
		class DataAlreadyLoaded < Exception; end
		
		module Loader
			class << self
				def db_empty?
					@nodata = Post.all.size() == 0
				end
			end
		end
	end
end