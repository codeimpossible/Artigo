class MigratePostBody < ActiveRecord::Migration
  def self.up
    # move body fields to body_html
    Post.reset_column_information
    Post.find(:all).each { |p|
      post_db = Post.find(p.id, :select => "body")
      puts "Migrating #{p.title}"
      p.update_attribute :body_html, post_db[:body]
    }
    remove_column :posts, :body
  end

  def self.down
    # move body_html fields to body
    add_column :posts, :body, :text
    Post.reset_column_information
    Post.find(:all).each { |p|
      p.update_attribute :body, p.body_html if p.body_html
    }
  end
end
