class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.references :province
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
