class CreateItemStatuses < ActiveRecord::Migration
  def self.up
    create_table :item_statuses do |t|
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :item_statuses
  end
end
