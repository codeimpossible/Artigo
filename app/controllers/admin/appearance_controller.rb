class Admin::AppearanceController < ApplicationController
  def index
	rt = ::Rails.root.to_s
	Dir.chdir("#{rt}/app/views/themes")
	@themes = Dir['*/'].collect{ |t| t.chomp("/") }
	@
  end
end
