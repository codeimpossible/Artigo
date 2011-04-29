class Admin::ManagepostsController < ApplicationController
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
	redirect_to "/admin/manageposts"
  end
end
