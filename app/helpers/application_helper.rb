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
	
	def post_permalink(p)
		d = p.created_at
		post_permalink_path :year => d.year, 
						:month => d.month, 
						:day => d.day, 
						:slug => p.permalink || p.to_perm
	end
end
