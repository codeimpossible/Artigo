require 'ostruct'

class Admin::ConfigController < Admin::BaseController
    def edit	
	
    end

    def update
        params.each { |key,value|
            Artigo::CONFIG.first[key] = value
        }

        Artigo::CONFIG.write

        if params[:newtheme].nil?
            redirect_to :action => 'index'
        else
            render :nothing => true
        end
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
