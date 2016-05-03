module Luz
  class OrderProduct

    attr_accessor :products, :order

    def initialize(order)
      @products = []
      @order = order
    end

    def add_product(product)
      products << product
    end
    
    def total
      total = @products.sum(&:price)
      total_with_coupon = @order.coupon.apply_discount(total)
      total_with_coupon = 0
      if @products.size === (2..4)
        total_with_coupon -= (5 * @products.size) / 100
      else
        total_with_coupon = total
      end
      
      return [total_with_coupon, total_with_coupon].min
    end

  end
end
