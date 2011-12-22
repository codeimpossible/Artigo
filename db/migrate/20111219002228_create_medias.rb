class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias do |t|
      t.string :title
      t.string :description
      t.string :path
      t.string :content_type
      t.integer :size

      t.timestamps
    end
  end

  def self.down
    drop_table :medias
  end
end
