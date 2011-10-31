require 'ostruct'

class Admin::ConfigController < ApplicationController
  layout "admin"
	
  def index	
	rt = ::Rails.root.to_s
	Dir.chdir("#{rt}/app/views/themes")
	@themes = Dir['*/'].collect{ |t| t.chomp("/") }
	@model = OpenStruct.new :options => Artigo::CONFIG, :themes => @themes
  end

  def save
	
	#wake up every morning feeling like pdata
	pdata = request.raw_post.gsub(/(authenticity_token=[^&]+)|(u?tf8=[^&]+)/i,"")[1..-1]
	
	yaml = CGI::parse(pdata).to_yaml
	
	Artigo.store_config yaml
	
	flash[:notice] = 'Artigo configuration was saved successfully.'
	redirect_to :action => 'index'
  end
  
  def changetheme
	
	logger.debug params[:newtheme]
	Artigo::CONFIG["app_theme"][0] = params[:newtheme]
	curr_yaml = Artigo::CONFIG.to_yaml
	Artigo.store_config curr_yaml
	
	logger.debug curr_yaml
	
	render :text => params[:newtheme]
  end
end
