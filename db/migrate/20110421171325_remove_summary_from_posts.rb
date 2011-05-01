class RemoveSummaryFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :summary
  end

  def self.down
    add_column :posts, :summary, :string
  end
end
