class PostsController < ApplicationController
  before_filter :login_required, :except =>  [:index, :show, :page, :rss]
  
  def index
    if( current_user != nil )
      @posts = Post.paginate( :page => params[:page], :order => 'created_at DESC' )
    else
      @posts = Post.public.paginate( :page => params[:page], :order => 'created_at DESC' )
    end
    
    respond_to do |format|
      format.html # index.html.erb
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
        format.html # show.html.erb
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
      format.html { render "index" }
      format.xml  { render :xml => @posts }
	  format.json { render :json => @posts }
    end
  end
  
  
  def rss
    @posts = Post.public.find(:all, :order => 'created_at DESC', :limit => 10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new
    
    @post.title = params[:title]
    @post.summary = params[:summary]
    @post.body = params[:content]
    
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
  
  def edit
	@post = Post.find_by_id(params[:id])
  end
  
  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    
    @post.title = params[:title] if not params[:title].blank?
    @post.summary = params[:summary] if not params[:summary].blank?
    @post.body = params[:content] if not params[:content].blank?
    @post.published = params[:post_published] if not params[:post_published].blank?
    
	logger.debug params[:date_type]
	logger.debug params[:post_created_at]
	
	should_change_date = params[:date_type].blank? ? false : params[:date_type] != "default"
	if should_change_date
		if params[:date_type] == "today"
			@post.created_at = Date.today
		else 
			@post.created_at = Date.parse params[:post_created_at] 
		end
	end
	
    respond_to do |format|
      if @post.save
        format.html { redirect_to( permalink(@post) ) }
        format.json { render :json => @post }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => "fail" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to(root_url) }
      format.xml  { head :ok }
    end
  end
end
