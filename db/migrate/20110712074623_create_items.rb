class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.date :start_date
      t.date :expiry_date
      t.references :item_status
      t.references :item_category
      t.references :order
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
