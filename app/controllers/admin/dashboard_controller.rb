require 'ostruct'

class Admin::DashboardController < ApplicationController
  before_filter :login_required
  layout "admin"
  
  Theme = Struct.new(:title, :description, :image)
  
  def index
  
    @model = OpenStruct.new :total_posts_private => Post.private.size,
                            :total_posts_public => Post.public.size,
							:themes => getthemes
  end

  
  private
  def getthemes
	
	list = []
	#load themes
	Dir.chdir("#{::Rails.root}/app/views/themes")
	@themes = Dir['*/'].collect{ |t| t.chomp("/") }
	@themes.each { |t|
		theme = Theme.new
		#check to see if the theme has an image
		thumbpath = "#{::Rails.root}/public/themes/#{t}/thumb.png"
		descpath = "#{::Rails.root}/public/themes/#{t}/description.txt"
		theme.image = File.exist? "public/themes/#{t}/thumb.png" ? thumbpath : "public/themes/default.png"
		theme.title = t
		theme.description = IO.read(descpath) if File.exist? descpath
		
		list.push theme
	}
	return list
  end
end
