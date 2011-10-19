class TagsController < ApplicationController
  def index
	@tags = Post.public.tag_counts_on(:tags) 
	respond_to do |format|
		format.html { 
			render "index", 
			:layout => "themes/#{Artigo::CONFIG["app_theme"].first}/layouts/main"  
		}
		format.xml  { render :xml => @tags }
    end
  end

  def show
	@posts = Post.public.tagged_with(params[:id])
	
	respond_to do |format|
		format.html { 
			render "show", 
			:layout => "themes/#{Artigo::CONFIG["app_theme"].first}/layouts/main"  
		}
		format.xml  { render :xml => @posts }
    end
  end

end
