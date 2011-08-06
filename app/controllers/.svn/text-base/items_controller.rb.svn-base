class ItemsController < ApplicationController
  
  before_filter :admin_authenticate, :only => [:manage_items, :destroy]  
  
  # display the items in an order
  def display_order_detail
    if current_user and (current_user.role_id == 1 or current_user.id == Order.find(params[:order_id]).user_id)
      @order = Order.find(params[:order_id])
      @items = Item.find_all_by_order_id(params[:order_id])
      render :action => "display_order_detail"
    else
      redirect_to(root_url, :notice => 'You cannot view the order detail!')
    end
  end
  
  # for items management by admins
  def manage_items
    @pending_items = Item.find_all_by_item_status_id(1)
    @for_sale_items = Item.find_all_by_item_status_id(2)
    @free_items = Item.find_all_by_item_status_id(3)
    @claimed_items = Item.find_all_by_item_status_id(4)
    @sold_items = Item.find_all_by_item_status_id(5)
  end

  # GET /items
  def index
    if current_user and current_user.role_id == 1
      redirect_to(admin_main_url)
    else
      @items = Item.all
      @tags= Item.all_tags
    
      respond_to do |format|
        format.html # show.html.erb
        format.json  { render :json => @tags }
      end
    end
  end
  
  # GET /items/1
  def show
    @item = Item.find(params[:id])
    if @item.item_status_id != 1 or (current_user and @item.user_id == current_user.id) or (current_user and current_user.role_id == 1)
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @item }
      end
    else
      redirect_to(root_url, :notice => 'You cannot view the item!')
    end
  end

  # GET /items/new
  def new
    if current_user
      if current_user.role_id != 1
        @item = Item.new(:item_status_id => 1)
        @statuses = ItemStatus.all
      else
        redirect_to(admin_main_url, :notice => 'Admin cannot start a new consignment.')
      end
    else
      redirect_to(log_in_url, :notice => 'You must log in to start a new consignment!')
    end
    @tags= Item.all_tags
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    if current_user and (current_user.role_id == 1 or (@item != nil and @item.item_status_id == 1 and current_user.id == @item.user_id))
      @statuses = ItemStatus.all
      @tags= Item.all_tags
    else
      redirect_to(root_url, :notice => 'You cannot edit the item!')
    end
  end

  # POST /items
  def create
    if current_user and current_user.role_id != 1
      @item = Item.new(params[:item])
      @statuses = ItemStatus.all
      @tags= Item.all_tags
    
      @item.user_id = current_user.id
      @item.item_status_id = 1
    
      #if price is 0, set status to free
      if @item.free?
        @item.item_status_id = 3
      end
    
      if @item.save
        Notifier.new_item(@item).deliver
        redirect_to(@item, :notice => 'Item was successfully created.')
      else
        render :action => "new"
      end
    end
  end

  def delete_images       
    params[:image_ids] ||= []
    unless params[:image_ids].empty?
      if @item.images.count > params[:image_ids].count
        Image.destroy_pics(params[:id], params[:image_ids])
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])
    @statuses = ItemStatus.all
    @tags= Item.all_tags
    
    delete_images    

    respond_to do |format|
      if @item.update_attributes(params[:item])
        if current_user and current_user.role_id == 1
          Notifier.item_updated(@item).deliver
          format.html { redirect_to(manage_items_url, :notice => 'Item was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
          format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(manage_items_url, :notice => 'Item was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  def search
    @tags= Item.all_tags
    search_input = params[:SearchInput]
    @search_results = Item.tagged_with(search_input)
  end

end