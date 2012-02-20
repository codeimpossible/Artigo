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
  	#todo: move this to some kind of theme dispatcher???
  	#this feels dirty
    theme = Artigo.get_conf("app_theme")
    options = ThemeSetting.for_theme(theme)

    @model = ThemedViewModel.new(nil, options)

    respond_to do |type|
      type.all {
        render  :template => "themes/#{theme}/errors/404",
                :layout => "themes/#{theme}/layouts/main",
                :status => 404
      }
    end
    true
  end

  def render_post_not_found
    render_404
  end

  def permalink(p)
		d = p.created_at
		post_permalink_path :year => d.year,
						            :month => d.month,
						            :day => d.day,
						            :slug => p.permalink || p.to_perm
  end

  def view_post_link(post, text="View Post")
    "<a href='#{permalink(post)}'>View Post</a>"
  end
end
