require 'ostruct'

class Admin::DashboardController < Admin::BaseController
  Theme = Struct.new( :title, :description, :image, :has_settings )
  
  def index
  
    @model = OpenStruct.new :total_posts_private => Post.private.size,
                            :total_posts_public => Post.public.size,
		                        :themes => getthemes
  end

  
  private
  def getthemes
  	list = []
  	#load themes
  	theme_app_path = "#{::Rails.root}/app/views/themes"
  	Dir.chdir(theme_app_path)
  	@themes = Dir['*/'].collect{ |t| t.chomp("/") }
  	@themes.each { |t|
  		theme = Theme.new
  		#check to see if the theme has an image
  		theme_abs_dir = "#{::Rails.root}/public/themes/#{t}"
  		thumbpath = "#{theme_abs_dir}/thumb.png"
  		descpath = "#{theme_abs_dir}//description.txt"
  		theme.image = (File.exist? thumbpath) ? "themes/#{t}/thumb.png" : "themes/default.png"
  		theme.title = t
  		theme.description = IO.read(descpath) if File.exist? descpath
  		theme.has_settings = File.exist? "#{theme_app_path}/#{t}/partials/_settings.html.erb"
  		
  		list.push theme
  	}
  	return list
  end
end
