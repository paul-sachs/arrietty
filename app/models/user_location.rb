class UserLocation < ActiveRecord::Base
  belongs_to :users
  
  acts_as_mappable :default_units => :kms
end
