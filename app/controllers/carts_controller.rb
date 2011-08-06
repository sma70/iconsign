class CartsController < ApplicationController
  # GET /carts
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  def show
    begin
      @cart = current_cart && Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to items_url, :notice => 'Invalid cart'
    end  
  end
  
  # GET /carts/new
  # def new
    # @cart = Cart.new
  # end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # invoked when setting the session for the cart
  def create
    @cart = Cart.new(params[:cart])
    
    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  def update
    @cart = Cart.find(params[:id])

    if @cart.update_attributes(params[:cart])
      redirect_to(@cart, :notice => 'Cart was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  #POST
  #add an item to the cart, invoked by clicking on "add to cart" button
  def add
    begin
      @cart = current_cart 
      item = @cart.items.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      item = Item.find(params[:id])
      @cart.items << item 
      respond_to do |format|
        format.html { redirect_to(@cart) }
        format.js   { @current_item = @item }
      end
    else
      redirect_to(items_url, :notice => 'The item is already in your cart.') 
    end
  end
  
  #remove an item from the cart:
  def remove
    @cart = current_cart
    item = @cart.items.find(params[:id])
    @cart.items.delete(item)
    
    respond_to do |format|
       format.html { redirect_to(@cart) }
       format.js   { @current_item = @item }
    end
  end

  # DELETE
  # invoked by empty cart
  def destroy
    current_cart.destroy
    #session[:cart_id] = nil
    redirect_to(items_url, :notice => 'Your cart is now empty')
  end
  

  
end
