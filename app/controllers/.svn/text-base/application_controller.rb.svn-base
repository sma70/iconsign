class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user 
  helper_method :current_cart 
  
  private 
  
  # Sets the @current_user instance variable 
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
#  def current_user
#    @_current_user ||= session[:current_user_id] &&
#    User.find(session[:current_user_id])
#  end
  
  #find or create a cart seesion:
  def current_cart 
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    if current_user && current_user.cart
      @cart = current_user.cart
    else
      @cart = Cart.create
    end
    #if current_user
      #@cart = @user.build_cart
     # @cart = Cart.new(params[:user_id]=>current_user)
    #else
    #end
    session[:cart_id] = @cart
  end


  def admin_authenticate
    if current_user == nil or current_user.role_id != 1
      redirect_to(root_url, :notice => 'You cannot access the admin-only page!')
    end
  end

# 
  # def session_cart!
    # if cookies[:cart_id]
      # @session_cart = Cart.includes(:shopping_cart_items).find_by_id(cookies[:cart_id])
      # unless @session_cart
        # @session_cart = Cart.create
        # cookies[:cart_id] = @session_cart.id
      # end
    # elsif current_user && current_user.current_cart
      # @session_cart = current_user.current_cart
      # cookies[:cart_id] = @session_cart.id
    # else
      # @session_cart = Cart.create
      # cookies[:cart_id] = @session_cart.id
    # end
    # @session_cart
  # end
#   
end
