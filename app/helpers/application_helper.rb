module ApplicationHelper
	def admin?
		@admin = self.current_user != nil
	end
	
	def is_dev?
		@dev = RAILS_ENV == "development"
	end
	
	def content_exists?(name)
		return instance_variable_get("@content_for_#{name}")
	end
	
	def is_active?(desc= {})
		desc[:controller] = "home" if desc[:controller] == nil
	
		@actionMatch = desc[:action] == nil || params[:action] == desc[:action]
		@idMatch = desc[:id] == nil || params[:id] == desc[:id]
		@isactive = @actionMatch && @idMatch && params[:controller] == desc[:controller]
    
		return @isactive
	end
end
