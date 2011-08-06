class Address < ActiveRecord::Base
  belongs_to :province
  belongs_to :user
  has_many :orders
  
  validates_presence_of :street_address, :city, :postal_code,:province_id
  validates_format_of :postal_code, :with => /^[a-z]{1}\d{1}[a-z]{1}\s*\d{1}[a-z]{1}\d{1}\s*\z/i, :if=>:postal_code?
  def to_s
    prov = Province.find(province_id)
    "#{street_address}, \n#{city.capitalize}, #{prov.name}, \n#{postal_code}, Canada"
  end

end