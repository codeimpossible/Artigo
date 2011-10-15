class Admin::PostsController < ApplicationController
  layout "admin"

  def index
    @posts = Post.find(:all, :order => "created_at DESC")
  end

  def manage
	num_posts = params[:posts].size
	if params[:act] == "delete"
		Post.bulk_delete(params[:posts])
	else 
		Post.bulk_set_published(params[:posts],params[:act] == "publish")
	end
	flash[:notice] = "#{num_posts} posts were #{params[:act]}ed."
	redirect_to "/admin/posts"
  end

  # GET /admin/posts/new
  # GET /admin/posts/new.xml
  def new
    @post = Post.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  # POST /admin/posts
  # POST /admin/posts.xml
  def create
    @post = Post.new
    
    @post.title = params[:title]
    @post.summary = params[:summary]
    @post.body = params[:content]

    logger.debug @post    

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to( permalink(@post) ) }
        format.json { render :json => @post }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => "fail" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
end
