class Admin::ThemeSettingsController < ApplicationController
	layout "admin"
	
  def edit
	theme = params[:theme]
	settings = ThemeSetting.for_theme(theme)
	
	@model = SettingsViewModel.new(theme, settings)
	
	logger.debug @model
  end

  def save
	theme = params[:theme]
	
	#remove all of the previous settings
	settings = ThemeSetting.for_theme(theme)
	
	ThemeSetting.delete(settings)
	
	params.each do |key, value|
		if key != 'theme' && key != 'authenticity_token' && key != 'utf8' 
			logger.debug "HELLO"
			logger.debug key
			logger.debug value
			
			t = ThemeSetting.new(:theme => theme, :name => key, :value => value )
			t.save
		end
	end
	
	flash[:notice] = 'Theme settings were saved successfully.'
	
	redirect_to :action => "edit", :theme => theme
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
