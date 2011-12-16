class CreateThemeSettings < ActiveRecord::Migration
  def self.up
    create_table :theme_settings do |t|
      t.string :name, :limit => 128
      t.string :value, :limit => 512
	  t.string :theme, :limit => 512

      t.timestamps
    end
  end

  def self.down
    drop_table :theme_settings
  end
end
