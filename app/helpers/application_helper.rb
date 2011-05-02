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
end
