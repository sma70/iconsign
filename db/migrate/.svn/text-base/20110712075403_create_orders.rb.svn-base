class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.date :order_date
      t.date :ship_date
      t.decimal :amount
      t.references :user
      t.references :address
      t.references :order_status

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
