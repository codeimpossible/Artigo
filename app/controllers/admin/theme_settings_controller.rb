class Admin::ThemeSettingsController < Admin::BaseController
  def edit
		theme = params[:theme]
		settings = ThemeSetting.for_theme(theme)

		@model = SettingsViewModel.new(theme, settings)

		logger.debug @model
  end

  def save
		redirect_to :controller => '/application', :action => 'render_404' and return unless request.post?

		theme = params[:theme]

		#remove all of the previous settings
		settings = ThemeSetting.for_theme(theme)

		ThemeSetting.delete(settings)

		params.each do |key, value|
			unless "theme,authenticity_token,utf8,controller,action".split(',').include? key
				t = ThemeSetting.new(:theme => theme, :name => key, :value => value )
				t.save
			end
		end

		flash[:notice] = 'Theme settings were saved successfully.'

		redirect_to :action => "edit", :theme => theme
  end

  def choose
  	Artigo.set_conf "app_theme", params[:theme]

  	flash[:success] = "You are now using the '#{params[:theme]}' theme. Enjoy!"

	  redirect_to :controller => "dashboard", :action => "index"
  end
end

class SettingsViewModel
	attr_accessor :theme, :settings

	def initialize(theme, settings)
		@theme = theme
		@settings = settings
	end

	def setting(name)
		@result = ""
		@result = @settings.where("name = ?", name).first.value if @settings.where("name = ?", name).count > 0
	end
end
