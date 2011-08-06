class Image < ActiveRecord::Base
  belongs_to :item
  
  has_attached_file :picture, 
    :styles => { :medium => "300x300", :thumb => "80x80>" },
    :default_url => '/public/images/no_picture.jpg'

  attr_protected :picture_file_name, :picture_content_type, :picture_size
  
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg',
     'image/png', 'image/gif'], 
     :message => 'File type is not allowed (only jpg/png/gif images)'
  
  def self.destroy_pics(item, images)
    Image.find(images, :conditions => {:item_id => item}).each(&:destroy)
  end
end
