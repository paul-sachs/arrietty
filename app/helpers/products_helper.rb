module ProductsHelper

  def status_classes(product)
    case product.status.to_sym
      when :available
        'success'
      when :unavailable
        'alert'
      when :rented
        'warning'
    end
  end
  
  def status_classes_info(product) 
    product.status.to_s
  
  end

  def get_distance_display_for(product)
    distance = product.distance_to(current_user)
    if distance <= 10
      "< #{distance.to_i}km"
    else
      "< #{distance.round(-1)}km"
        
    end
  end
end
