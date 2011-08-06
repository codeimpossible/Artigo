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
	
	def is_active?(controller, action, id)
		controller = "home" if controller == nil
	
		@actionMatch = action == nil || params[:action] == action
		@idMatch = id == nil || params[:id] == id
		@isactive = @actionMatch && @idMatch && params[:controller] == controller
    
		return @isactive
	end
end
