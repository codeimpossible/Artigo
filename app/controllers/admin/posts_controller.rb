class Admin::PostsController < Admin::BaseController
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
    @post = Post.default
    
    @tags = Post.tag_counts_on(:tags)
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => post }
    end
  end
  
  # POST /admin/posts
  # POST /admin/posts.xml
  def create
    @post = Post.new
    
    @post.title = params[:post][:title]
    @post.summary = params[:post][:summary]
    @post.body = params[:post][:body]
    @post.tag_list = params[:post][:tags]

    logger.debug params[:post].inspect

    respond_to do |format|
      if @post.save
        logger.debug 'post saved, redirecting to #{edit_admin_post_path(@post)}'
        flash[:notice] = 'Post was successfully created.'
        format.html   { redirect_to( edit_admin_post_path(@post) ) }
        format.json   { render :json => @post }
        format.xml    { render :xml => @post, :status => :created, :location => @post }
      else
        format.html   { render :action => "new" }
        format.json   { render :json => "fail" }
        format.xml    { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @post = Post.find_by_id(params[:id])  
    @tags = Post.tag_counts_on(:tags)
  end
  
  # PUT /admin/posts/1
  # PUT /admin/posts/1.xml
  def update
    @post = Post.find(params[:id])
    
    @post.title = params[:title] if not params[:title].blank?
    @post.summary = params[:summary] if not params[:summary].blank?
    @post.body = params[:body] if not params[:body].blank?
    @post.published = params[:post_published] if not params[:post_published].blank?
    
    @post.tag_list = params[:tags]
  
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
        flash[:notice] = 'Changes saved successfully.'
        format.html { redirect_to :action => "index" }
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
