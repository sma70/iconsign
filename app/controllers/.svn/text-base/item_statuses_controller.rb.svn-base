class ItemStatusesController < ApplicationController

  def index
    @item_statuses = ItemStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @item_statuses }
    end
  end

  def show
    @item_status = ItemStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item_status }
    end
  end

  def new
    @item_status = ItemStatus.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item_status }
    end
  end

  def edit
    @item_status = ItemStatus.find(params[:id])
  end

  def create
    @item_status = ItemStatus.new(params[:item_status])
    
    respond_to do |format|
      if @item_status.save
        format.html { redirect_to(@item_status, :notice => 'Item_status was successfully created.') }
        format.xml  { render :xml => @item_status, :status => :created, :location => @item_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item_status = ItemStatus.find(params[:id])
  
    respond_to do |format|
      if @item_status.update_attributes(params[:item_status])
        format.html { redirect_to(@item_status, :notice => 'Item_status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item_status = ItemStatus.find(params[:id])
    @item_status.destroy

    respond_to do |format|
      format.html { redirect_to(item_status_url) }
      format.xml  { head :ok }
    end
  end
  
end