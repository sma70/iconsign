class OrdersController < ApplicationController

  before_filter :admin_authenticate, :except => [:new, :create]
  
  #admin: get all
  #customer: get orders belongs_to
  def index
    @waiting_for_payment_orders = Order.find_all_by_order_status_id(1)
    @received_orders = Order.find_all_by_order_status_id(2)
    @processing_orders = Order.find_all_by_order_status_id(3)
    @completed_orders = Order.find_all_by_order_status_id(4)
    @shipped_orders = Order.find_all_by_order_status_id(5)
  end

  
  # GET /orders/new
  def new    
    @cart = current_cart
    if @cart.items.empty?
      redirect_to items_url, :notice => "Your cart is empty"
      return
    end
    
    if !current_user
      redirect_to log_in_url, :notice => "Please log in to checkout your order"
      return
    end
    
    @cart.items.each do |item|
      if item.item_status_id == 5 || item.item_status_id ==4
        redirect_to(cart_path(@cart), :notice => 'One or more items in your cart are no longer available. Please remove them.')
        return
      end
      if current_user.id == item.user_id
        redirect_to(cart_path(@cart), :notice => 'One or more items in your cart belong to you. Please remove them.')
        return
      end
    end
    
    # unless item.item_status_id == 5 || item.item_status_id == 4 
       # if item.price==0
         # item.item_status_id = 4; #set item_status to "claimd"
       # else
         # item.item_status_id = 5; #set item_status to "sold"
       # end
     # end
      
    #redirect_to(cart_path(@cart), :notice => 'One or more items in your cart is no longer available.')
    @order = Order.new
    @user = current_user
    @address = Address.find_by_user_id(current_user)
  end
  
  # GET /orders/1/edit
  # admin: changing everything, including status
  # customer: change shipping address, items
  def edit
    @order = Order.find(params[:id])
    @order_statuses = OrderStatus.all
  end

  # POST /orders
  # should be initialed from checking out a Cart
  def create
    @order = Order.new(params[:order])
    @order.add_items_from_cart(session[:cart_id])
    @order.order_status_id = 1
    
    #if @order.unavailable_items?
      #redirect_to(items_path, :notice => 'One or more items in your cart is no longer available.')
    #if @order.items.size != current_cart.items_num
      #highlight the items that are no longer available
      #redirect_to(items_path, :notice => 'One or more items in your cart is no longer available.')
    #elsif @order.save
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      Notifier.order_received(@order).deliver
      redirect_to(items_path, :notice => 'Thank you for your order. A confirmation email will be sent to you shortly.')
    else
      render :action => "new" #when will it come here?
    end
   
  end

  # PUT /orders/1
  # if @order.update_attributes(params[:order])
    # @order.line_items = @order.line_items.select {|li| li.quantity > 0 }
    # fire_event('spree.order.contents_changed')
    # respond_with(@order) { |format| format.html { redirect_to cart_path } }
  # else
      # respond_with(@order)
  # end
  

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(orders_path, :notice => 'Order was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
