# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{ name: 'Tools'}, { name: 'Electronics'}, { name: 'Automotive'}, 
  {name: 'Services'}])
  
user1 = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user2 = User.create! :email => 'jane@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user3 = User.create! :email => 'alice@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
    
user1.products.create! :name => 'John\'s product', :price => '5.00', :description => 'Description', :status => 0
user1.user_location = UserLocation.create! :lng => -75.6972, :lat => 45.4215 

user4 = User.create! :email => 'bob@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user4.products.create! :name => 'Bob\'s product', :price => '5.00', :description => 'Description', :status => 0
user4.user_location = UserLocation.create! :lng => -81.3305, :lat => 48.4758 