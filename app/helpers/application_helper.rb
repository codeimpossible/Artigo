module ApplicationHelper
	include ActsAsTaggableOn::TagsHelper

	def admin?
		@admin = self.current_user != nil
	end

	def is_dev?
		@dev = ::Rails.env == "development"
	end

	def content_exists?(name)
		return instance_variable_get("@content_for_#{name.to_s}")
	end

	def artigo_config(name)
		@result = ""
		@result = Artigo.get_conf(name) if Artigo.get_conf(name)
	end

	def is_active?(desc= {})
		desc[:controller] = "home" if desc[:controller] == nil

		@actionMatch = desc[:action] == nil || params[:action] == desc[:action]
		@idMatch = desc[:id] == nil || params[:id] == desc[:id]
		@isactive = @actionMatch && @idMatch && params[:controller] == desc[:controller]

		return @isactive
	end

	def blog_stats
		{
			:total_posts_private => Post.private.size,
			:total_posts_public => Post.public.size
		}
	end

	def edit_post_link(post)
		"/admin/posts/edit/#{post.id}"
	end
end
