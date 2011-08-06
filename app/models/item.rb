class Item < ActiveRecord::Base
  validates :name, :description, :user_id, :presence => true
  validates_numericality_of :price, :greater_than_or_equal_to => 0
  #validate start_date and expiry_date
  validates :start_date,:date => { :before => :expiry_date,:if=>:start_date?}
  validates :expiry_date,:date => { :after => :start_date,:if=>:expiry_date?}
  validates_presence_of :images
  validates :name,:length => { :minimum => 3, :maximum => 40 }
  
  belongs_to :user
  belongs_to :order
  belongs_to :item_status
  belongs_to :item_category
  has_and_belongs_to_many :tags 
  has_and_belongs_to_many :carts
  has_many :images, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  acts_as_taggable
  #acts_as_taggable_on :categorys
  acts_as_taggable_on :tags
  accepts_nested_attributes_for :images, :allow_destroy => :true
  
  
  def status
    ItemStatus.find(self.item_status_id).status
  end
  
  def free?
    self.price == 0
  end
  
  def self.all_tags
    tags=[]
    Item.all.each do |item|
      tags = tags + item.tag_list
    end
    return tags.uniq
  end
  #before_destroy :check_cart_reference
  #before_destroy :check_order_reference

    
  accepts_nested_attributes_for :images, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  


end
