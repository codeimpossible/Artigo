class Post < ActiveRecord::Base
	before_save :create_permalink
	
	named_scope :private, :conditions => ["published = ?", "f"]
	named_scope :public, :conditions => ["published = ?", "t"]
	
	cattr_reader :per_page
	@@per_page = 5
	
	def to_perm
		"#{title.gsub(/&.{1,4};/i,'-').gsub(/[^a-z0-9]+/i, '-')}"
	end
	
	def self.bulk_set_published(posts, pub)
		posts.each do |post_id|
			post = Post.find(post_id)
			post.published = pub
			post.save
		end
	end
	
	def self.bulk_delete(posts)
		posts.each do |post_id|
			post = Post.find(post_id)
			post.destroy
		end
	end
		
	private
	def create_permalink
		self.permalink = "#{title.gsub(/&.{1,4};/i,'-').gsub(/[^a-z0-9]+/i, '-')}"
	end
end
