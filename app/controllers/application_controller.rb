require File.join(Rails.root, 'lib', 'authenticated_system.rb')

class Error404 < StandardError; end
class PostNotFound < Error404; end

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout "main"
  include AuthenticatedSystem
  helper_method :permalink
  
  rescue_from ActionController::RoutingError, :with => :render_404
  rescue_from Error404, :with => :render_404
  rescue_from PostNotFound, :with => :render_post_not_found
  
  def not_found
    raise Error404
  end
  
  def render_404
    respond_to do |type| 
      type.html { render :template => "errors/error_404", :status => 404 } 
      type.all  { render :nothing => true, :status => 404 } 
    end
    true
  end

  def render_post_not_found
    respond_to do |type| 
      type.html { render :template => "errors/post_not_found", :status => 404 } 
      type.all  { render :nothing => true, :status => 404 } 
    end
    true
  end
  
  def permalink(p)
		d = p.created_at
		post_permalink_path :year => d.year, 
						:month => d.month, 
						:day => d.day, 
						:slug => p.permalink || p.to_perm
  end
end
