class ThemeSetting < ActiveRecord::Base
	scope :for_theme, lambda { |t| { :conditions => [ "theme = ?", t] } }
end
