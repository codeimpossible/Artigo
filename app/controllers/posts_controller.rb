class PostsController < ApplicationController
  before_filter :login_required, :except =>  [:index, :show, :page, :rss]
  
  def index
    if( current_user != nil )
      posts = Post.paginate( :page => params[:page], :order => 'created_at DESC' )
    else
      posts = Post.public.paginate( :page => params[:page], :order => 'created_at DESC' )
    end
	
	theme = Artigo.get_conf("app_theme")
	
	options = ThemeSetting.for_theme(theme)
	
	@model = ThemedViewModel.new(posts, options)
    
    respond_to do |format|
		format.html { 
			render "themes/#{theme}/posts/index", 
			:layout => "themes/#{theme}/layouts/main"  
		}
		format.xml  { render :xml => posts }
    end
  end
  
  def notfound
	
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show	
    if( current_user != nil )
      post = Post.find_by_permalink(params[:slug])
    else
      post = Post.public.find_by_permalink(params[:slug])
    end
	
	theme = Artigo.get_conf("app_theme")
	
	logger.debug "theme: #{theme}"
	
	options = ThemeSetting.for_theme(theme)
	
	@model = ThemedViewModel.new(post, options)
    
    if post == nil
      render_post_not_found 
    else
      respond_to do |format|
        format.html { 
			render "themes/#{theme}/posts/show", 
			:layout => "themes/#{theme}/layouts/main"  
		}
        format.xml  { render :xml => @post }
      end
    end
  end
  
  def page
    if( current_user != nil )
      posts = Post.paginate( :page => params[:page], :order => 'created_at DESC' )
    else
      posts = Post.public.paginate( :page => params[:page], :order => 'created_at DESC' )
    end
    
	theme = Artigo.get_conf("app_theme")
	
	options = ThemeSetting.for_theme(theme)
	
	@model = ThemedViewModel.new(posts, options)
	
    respond_to do |format|
		format.html { 
			render "themes/#{theme}/posts/index", 
			:layout => "themes/#{theme}/layouts/main"  
		}
		format.xml  { render :xml => @posts }
		format.json { render :json => @posts }
    end
  end
  
  
  def rss
    @posts = Post.public.find(:all, :order => 'created_at DESC', :limit => 10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
end