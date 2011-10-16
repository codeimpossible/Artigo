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
	
	logger.debug request.raw_post
	logger.debug pdata
	
	yaml = CGI::parse(pdata).to_yaml
	
	logger.debug yaml
	
	Artigo.store_config yaml
	
	flash[:notice] = 'Artigo configuration was saved successfully.'
	redirect_to :action => 'index'
  end
end
