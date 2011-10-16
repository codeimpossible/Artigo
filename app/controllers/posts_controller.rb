class PostsController < ApplicationController
  before_filter :login_required, :except =>  [:index, :show, :page, :rss]
  
  def index
    if( current_user != nil )
      @posts = Post.paginate( :page => params[:page], :order => 'created_at DESC' )
    else
      @posts = Post.public.paginate( :page => params[:page], :order => 'created_at DESC' )
    end
    
    respond_to do |format|
		format.html { 
			render "themes/#{Artigo::CONFIG["app_theme"].first}/posts/index", 
			:layout => "themes/#{Artigo::CONFIG["app_theme"].first}/layouts/main"  
		}
		format.xml  { render :xml => @posts }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show	
    if( current_user != nil )
      @post = Post.find_by_permalink(params[:slug])
    else
      @post = Post.public.find_by_permalink(params[:slug])
    end
    
    if @post == nil
      render_post_not_found 
    else
      respond_to do |format|
        format.html { 
			render "themes/#{Artigo::CONFIG["app_theme"].first}/posts/show", 
			:layout => "themes/#{Artigo::CONFIG["app_theme"].first}/layouts/main"  
		}
        format.xml  { render :xml => @post }
      end
    end
  end
  
  def page
    if( current_user != nil )
      @posts = Post.paginate( :page => params[:page], :order => 'created_at DESC' )
    else
      @posts = Post.public.paginate( :page => params[:page], :order => 'created_at DESC' )
    end
    
    respond_to do |format|
		format.html { 
			render "themes/#{Artigo::CONFIG["app_theme"].first}/posts/index", 
			:layout => "themes/#{Artigo::CONFIG["app_theme"].first}/layouts/main"  
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
