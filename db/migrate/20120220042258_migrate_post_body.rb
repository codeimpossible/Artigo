class MigratePostBody < ActiveRecord::Migration
  def self.up
    # move body fields to body_html
    Post.find(:all).each { |p|
      p.body_html = p.body
      p.save
    }
    remove_column :posts, :body
  end

  def self.down
    # move body_html fields to body
    add_column :posts, :body, :text
    Post.find(:all).each { |p|
      p.body = p.body_html
      p.save
    }
  end
end
