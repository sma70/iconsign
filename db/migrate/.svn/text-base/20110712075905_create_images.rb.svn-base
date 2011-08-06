class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :picture_file_name
      t.integer :picture_file_size #file size in bytes
      t.string :picture_content_type
      t.datetime :picture_updated_at
      
      t.references :item

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
