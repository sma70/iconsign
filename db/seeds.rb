# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Tag.create ([{ :name => 'rabbit' }, 
    # { :status => 'kitty' }, 
    # { :status => 'cat' }, 
    # { :status=> 'disney' }, 
    # { :status => 'mouse' },
    # { :status => 'mini' },
    # { :status=> 'princes' }, 
    # { :status => 'story' },
    # { :status => 'kids' }, 
    # { :status=> 'happiness' }, 
    # { :status => 'mouth' },
    # { :status => 'animal' },
    # { :status => 'states' },
    # { :status => 'parks' },
    # { :status => 'fairy tale' },
    # { :status => 'harry potter' },
    # { :status => 'movie' },
    # { :status => 'orange' },
    # { :status => 'roller coaster' }])
    
ItemStatus.create ([{ :status => 'Pending' }, 
    { :status => 'For Sale' }, 
    { :status => 'Free' }, 
    { :status=> 'Claimed' }, 
    { :status => 'Sold' }])

OrderStatus.create ([{ :status => 'Waiting For Payment' }, 
    { :status => 'Received' }, 
    { :status => 'Processing' }, 
    { :status => 'Completed' }, 
    { :status => 'Shipped' }]) 

Role.create ([{ :title => 'admin' }, 
    { :title => 'user' }]) 

Province.create ([{ :name => 'Alberta' }, 
    { :name => 'British Columbia' }, 
    { :name => 'Manitoba' }, 
    { :name => 'Quebec' }, 
    { :name => 'Ontario' }, 
    { :name => 'Saskatchewan' }, 
    { :name => 'Quebec' }, 
    { :name => 'Prince Edward Island' }, 
    { :name => 'Newfoundland and Labrador' },
    { :name => 'New Brunswick' }, 
    { :name => 'Yukon' }, 
    { :name => 'Nunavut' }, 
    { :name => 'Northwest Territories' }])

User.create (:email => 'admin@iconsign.ca',
    :first_name => 'first_name', 
    :last_name => 'last_name',
    :password => 'iconsign',
    :password_hash => '$2a$10$w6Kdsi2YLqjDhNpO6h53zu0jy93HWZj5XgzlBG2J.7UzSx13LsoKu',
    :password_salt => '$2a$10$w6Kdsi2YLqjDhNpO6h53zu0jy93HWZj5XgzlBG2J.7UzSx13LsoKu',
    :phone => "123-123-1234",
    :role_id => '1')
