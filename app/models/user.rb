class User < ActiveRecord::Base
	validates :email, uniqueness: true,
			  		  presence: true,
			  		  email: true
  	validates :first_name, presence: true

  	validates :last_name, presence: true

  	validates :phone, format: { with: /\(\d{3}\)\d{3}-\d{4}/},
  					  presence: true

end
