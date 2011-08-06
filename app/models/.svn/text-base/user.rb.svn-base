class User < ActiveRecord::Base
  belongs_to :role
  has_one :address, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  has_many :items, :dependent => :destroy
  has_one :cart, :dependent => :destroy
  
  validates_presence_of :first_name, :last_name  
  validates :email, :presence => true, :uniqueness => true, :length => { :maximum => 50 }
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :if=>:email?
  
  validates_confirmation_of :password
  validates :password, :presence => true, :length => {:maximum => 40 }, :on => :create
  validates :password, :length => { :minimum => 6 }, :if=>:email?
  
  validates_format_of :phone, :with => /\(?[0-9]{3}\)?[-. ]?[0-9]{3}[-. ]?[0-9]{4}[ ]*\z/, :if=>:phone?
  
  
  attr_accessor :password
  before_save :encrypt_password
  
  accepts_nested_attributes_for :address
    
  def User.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def full_name
    [first_name.capitalize, last_name.capitalize].compact.join(' ')
  end
end