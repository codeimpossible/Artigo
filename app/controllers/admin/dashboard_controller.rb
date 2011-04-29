require 'ostruct'

class Admin::DashboardController < ApplicationController
  before_filter :login_required
  
  def index
    @model = OpenStruct.new :total_posts_private => Post.private.size,
                            :total_posts_public => Post.public.size
  end

end
