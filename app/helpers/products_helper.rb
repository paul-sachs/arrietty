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
  
  def status_icon_classes(product) 
    case product.status.to_sym
      when :available
        'fi-check success'
      when :unavailable
        'fi-x alert'
      when :rented
        'fi-clock warning'
    end
  end
end
