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
      total = @products.map(&:price).inject(:+)
      total_with_coupon = @order.coupon.apply_discount(total) if @order.coupon
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
