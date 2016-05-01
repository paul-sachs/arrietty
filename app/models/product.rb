class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_one :user_location, through: :user
  alias_attribute :location, :user_location
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing_product.png" 
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
   
  enum status: [ :unavailable, :available, :rented]
  
  def self.not_owned_by(user) 
    Product.where.not(user_id: user.id)
  end
  
  def self.contains?(value)
    where("lower(name) LIKE ? OR lower(description) LIKE ?",
          "%#{value.downcase}%",
          "%#{value.downcase}%")
  end
  
  def distance_to(user)
    user.location.distance_from(location, :units => :kms)
  end
end