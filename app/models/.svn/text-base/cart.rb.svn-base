class Cart < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items
  
  def total_price
    items.to_a.sum { |item| item.price }
  end

  def items_num
    items.size
  end
  
  # def check_availability
    # items.each do |item|
      # if item.item_status_id == 5 || item.item_status_id ==4
        # return false
      # end
    # end
    # return true
  # end
  
  # def add_items_to_checkout(order)
    # if order.in_progress?
      # items = shopping_cart_items.inject({}) {|h, item| h[item.variant_id] = item.quantity; h}
      # order = items_to_add_or_destroy(items, order)
    # end
    # order
  # end
  
end
