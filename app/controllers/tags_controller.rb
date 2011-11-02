class TagsController < ApplicationController
  def index
	tags = Post.public.tag_counts_on(:tags)
	
	theme = Artigo.get_conf("app_theme")
	options = ThemeSetting.for_theme(theme)
	@model = ThemedViewModel.new(tags, options)
	
	respond_to do |format|
		format.html { 
			render "index", 
			:layout => "themes/#{theme}/layouts/main"  
		}
		format.xml  { render :xml => tags }
    end
  end

  def show
	posts = Post.public.tagged_with(params[:id])
	
	theme = Artigo.get_conf("app_theme")
	options = ThemeSetting.for_theme(theme)
	@model = ThemedViewModel.new(posts, options)
	
	respond_to do |format|
		format.html { 
			render "show", 
			:layout => "themes/#{theme}/layouts/main"  
		}
		format.xml  { render :xml => posts }
    end
  end  
end
