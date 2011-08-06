class Notifier < ActionMailer::Base
  default :from => "admin@iConsign.ca"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail :to => order.user.email, :subject => 'iConsign: Order Confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order
    @user = User.find(order.user_id)
    mail :to => order.user.email, :subject => 'iConsign: Order Shipped'
  end
  
  def comment_posted(comment)
    @comment = comment
    @commenter = User.find(comment.user_id)
    mail :to => comment.item.user.email, :subject => 'iConsign: Comment Posted on your consignment item'
  end
  
  def item_sold(item)
    @item = item
    mail :to => item.user.email, :subject => 'iConsign: Item Sold'
  end
  
  def new_item(item)
    @item = item
    admins = User.where(:role_id => 1)
    admins.each do |admin|
      @admin = admin
      mail :to => admin.email, :subject => 'iConsign: New Consignment Item for Review'
    end
  end
  
  def item_updated(item)
    @item = item
    mail :to => item.user.email, :subject => 'iConsign: Item Updated'
  end
  
  def notify_admin(comment)
    @comment = comment
    @commenter = User.find(comment.user_id)
    admins = User.where(:role_id => 1)
    admins.each do |admin|
      @admin = admin
      mail :to => admin.email, :subject => 'iConsign: Inapproriate Comment Flagged'
    end
  end
  
  def password_reset(user, password)
    @user = user
    @password = password
    mail :to => user.email, :subject => 'iConsign: Your password has been reset.'
  end
end
