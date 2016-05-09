require "luz/order"
require 'luz/coupon'
require 'luz/product'

module Luz
    class Finance

        def calculate(orders)
          results = []
          orders.each do |order|
            total = total(order.products, order.coupon)
            results << Result.new(order.id, total)
          end
          results
        end
        
        def total(products, coupon)
          total = products.map(&:price).inject(:+)
          total_with_coupon = self.calculate_coupon_discount(coupon, total)
          total_without_coupon =  self.apply_common_discount(total, products.size)
          
          if (coupon and coupon.valid? and (total_with_coupon < total_without_coupon))
              coupon.mark_used
              return total_with_coupon
          else
              return total_without_coupon
          end
        end
    
        def apply_common_discount(total, qtd)
          return total if qtd < 2
          discount = (qtd >= 8) ? 40 : 5 * qtd
          return total - (total * discount / 100)
        end
        
        def calculate_coupon_discount(coupon, value)
            return value if !coupon
            case coupon.type
                when 'absolute' 
                    return (value > coupon.discount) ? value - coupon.discount : 0 #negative values dont exists
                when 'percent' 
                    return (coupon.discount <= 100) ? value - (value * coupon.discount / 100) : 0
            end

        end
    end
end
