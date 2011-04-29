class Admin::ConfigController < ApplicationController
	
  def index
	@options = Artigo::CONFIG
  end

  def save
	
	#wake up every morning feeling like pdata
	pdata = request.raw_post.gsub(/(authenticity_token=[^&]+)/i,"")[1..-1]
	
	logger.debug request.raw_post
	logger.debug pdata
	
	yaml = CGI::parse(pdata).to_yaml
	
	logger.debug yaml
	
	Artigo.store_config yaml
	
	flash[:notice] = 'Artigo configuration was saved successfully.'
	redirect_to :action => 'index'
  end
end
