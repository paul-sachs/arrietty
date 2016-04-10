class AddStatusToProduct < ActiveRecord::Migration
  def up
    add_column :products, :status, :integer, default: 0
    
    Product.find_each do |p| 
      p.status = 0
      p.save
    end
  end
  
  def down
    remove_column :products, :status
  end
end
