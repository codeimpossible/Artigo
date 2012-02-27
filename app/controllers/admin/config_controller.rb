require 'ostruct'

class Admin::ConfigController < Admin::BaseController
  def edit

  end

  def update
    params.each { |key,value|
      Artigo::CONFIG.first[key] = value
    }

    Artigo::CONFIG.write

    redirect_to :action => 'index'
  end
end
