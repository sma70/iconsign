class CreateCartsItems < ActiveRecord::Migration
  def self.up
    create_table :carts_items, :id => false do |t|
      t.integer :cart_id
      t.integer :item_id
    end
  end

  def self.down
    drop_table :carts_items
  end
end
