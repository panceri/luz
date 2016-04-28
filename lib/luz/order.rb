require 'product'
require 'coupon'
module Luz
    class Order
        @@coupon = nil
        @@products = nil
        def initialize(array)
            
        end
        
        def total
            total = @@products.sum(&:price)
            total_with_coupon = @@coupon.calculate_discount(total)
            total_with_progressive_discount = 
        end
    end
end
