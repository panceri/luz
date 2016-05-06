require 'luz/coupon'
require 'luz/product'

module Luz
    class Order
        
        attr_accessor :id
        attr_accessor :coupon
        attr_accessor :products

        def initialize(id, coupon = nil)
            @id = id.to_i;
            @coupon = coupon
            @products = Array.new
        end
        
        def add_product(product)
            @products << product
        end
        
        def total
          total = @products.map(&:price).inject(:+)
          total_with_coupon = coupon.apply_discount(total) if @coupon
          total_without_coupon =  apply_common_discount(total, @products.size)
          return [total_without_coupon, total_with_coupon].min if total_with_coupon
          return total_without_coupon
        end
    
        private
    
        def apply_common_discount(total, qtd)
          return total if qtd < 2
          discount = (qtd >= 8) ? 40 : 5 * qtd
          return total - (total * discount / 100)
        end
        
    end
end
