class UsersController < ApplicationController  
  
  before_filter :admin_authenticate, :only => [:index, :destroy, :admin_main]
  
  # GET /users
  # Method to return all users:
  def index
      @users = User.paginate :page=>params[:page], :order=>'created_at desc',:per_page => 20
  end

  # GET /users/1
  # Method for showing a user based on user_id:
  def show
    if current_user && (current_user.id == params[:id].to_i || current_user.role_id == 1)
      @user = User.find(params[:id])
    else
      redirect_to(root_url, :notice => 'You cannot view other user\'s detail!')
    end
  end
  
  # GET /users/new
  # GET /users/new.xml
  # Method for creating a new user:
  def new
    @user = User.new
    @address = @user.build_address
    @provinces = Province.order("name ASC") #pass in the provinces list for address
  end

  # GET /users/1/edit
  # Method for editing user:
  def edit
    if current_user && (current_user.id == params[:id].to_i || current_user.role_id == 1)
      @user = User.find(params[:id])
      @provinces = Province.order("name ASC")
    else
      redirect_to(root_url, :notice => 'You cannot edit other user\'s details!')
    end
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @provinces = Province.order("name ASC")
    @user.address.province_id = params[:address][:province_id]
    @user.role_id = 2

    if @user.save
      if current_user and current_user.role_id == 1
        redirect_to(users_path, :notice => "User has be added.")
      else
        redirect_to(root_url, :notice => 'Signed up! Please login with your new account.')
      end
    else
      render :action => "new" 
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  # Method for updating user:
  def update
    if current_user && (current_user.id == params[:id].to_i || current_user.role_id == 1)
      @user = User.find(params[:id])
      @provinces = Province.order("name ASC")
      @user.address.province_id = params[:address][:province_id]

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  # Method for destroying user:
  def destroy
    if params[:id].to_i != 1
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(manage_users_url, :notice => 'User was successfully deleted.') }
        format.xml  { head :ok }
      end
    else
      redirect_to(root_url, :notice => 'You cannot delete the root admin.')
    end
  end
  
  # view my orders
  def my_orders
    if current_user
      if current_user.role_id != 1
        @my_orders = current_user.orders
        #render :action => 'my_orders'
      else
        redirect_to(admin_main_url, :notice => 'Admin has no orders.')
      end
    else
      redirect_to(root_url, :notice => 'Login is required to view your orders.')
    end
  end
  
  # the controller for admin main page
  def admin_main
    @pending_items = Item.find_all_by_item_status_id(1)
    @received_orders = Order.find_all_by_order_status_id(2)
    @completed_orders = Order.find_all_by_order_status_id(4)
  end
  
  # the action for the my_items page
  def my_items
    if current_user
      if current_user.role_id != 1
        @my_items = current_user.items
      
        @num_items_sold = Item.where(:user_id => current_user.id, :item_status_id => 5).count
      
        @total_amount_earned = 0
        @my_items.each do |item|
          if item.item_status_id == 5
            @total_amount_earned += item.price*0.50
          end
        end
        render :template => 'users/my_items'
      else
        redirect_to(admin_main_url, :notice => 'Admin has no consignments.')
      end
    else
      redirect_to(log_in_url, :notice => 'Please log in to see your consignments.')
    end
  end
  
  # changes the password
  def forgot_password
    user = User.find_by_email(params[:email])
    @password = SecureRandom.hex(4)
    user.password = @password
    user.save
    @user = user
    Notifier.password_reset(@user, @password).deliver
    redirect_to(log_in_url, :notice => "Please login with the temporary password we sent you and change it.")
  end
    
end