class UserLocation < ActiveRecord::Base
  belongs_to :users
  
  acts_as_mapable :default_units => :kms
end
