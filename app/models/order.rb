class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
  belongs_to :order_status
  has_many :items
  
  #accepts_nested_attributes_for :addresses

  def add_items_from_cart(cart)    
    cart.items.each do |item|
      #item.cart_id = nil #done by rails
      #item_status is "sold"(5) or "claimed"(4)= unavailable then don't associate to the order
      unless item.item_status_id == 5 || item.item_status_id == 4 
        if item.price==0
          item.item_status_id = 4; #set item_status to "claimd"
        else
          item.item_status_id = 5; #set item_status to "sold"
        end
        @item = item
        Notifier.item_sold(@item).deliver
        items << item
      end
    end
  end
  
  
  def checkout_ready?
    items.count > 0
  end
  
  def status
    OrderStatus.find(self.order_status_id).status
  end
  # skip payment if this is a free item
  def payment_required?
    total.to_f > 0.0
  end

end
