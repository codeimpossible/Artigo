class Admin::TidyupController < Admin::BaseController
  def index
  end

  def tidyposts
    if params[:post_type].downcase.eql?("all")
      # this feels a bit dirty
      Post.all.map(&:destroy)
    end
    
    flash[:notice] = "All your posts have been removed from the blog"
    
    redirect_to :action => "index"    
  end
end
