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
          total_with_coupon = coupon.apply_discount(total) if coupon
          total_without_coupon =  apply_common_discount(total, products.size)
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
