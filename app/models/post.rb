class Post < ActiveRecord::Base
	before_save :create_permalink
	acts_as_taggable
	validates_presence_of :body

	@@per_page = Artigo.get_conf("posts_per_page").to_i

	scope :private, :conditions => ["published = ?", false]
	scope :public, :conditions => ["published = ?", true]
	scope :recent, :limit => @@per_page

	cattr_reader :per_page
	attr_accessible :title, :body, :summary, :tags

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

	def self.default
		title = "Your new posts title"
		summary = "Write 2-3 sentences to grab your readers' attention. The ending should act as an introduction into your main body."
		body = <<-HTML
<p>Your main body should fully realize the ideas you set into motion in the introduction section. Keep your posts short
    and to the point as shorter blog posts are easier to read and remember.</p>

<p>Use a consistent style in your writing, once you've picked a style that suites you and your audience, stick to it.</p>

<p>Be your own editor. Before you publish your post, go back and re-read it. Does it sound like you? Does it make sense? Does it get right to the point?</p>
    HTML
		Post.new :summary => summary, :body => body, :title => title
	end

	private
	def create_permalink
		self.permalink = "#{title.gsub(/&.{1,4};/i,'-').gsub(/[^a-z0-9]+/i, '-')}"
	end
end
