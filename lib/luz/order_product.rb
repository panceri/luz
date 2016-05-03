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

  end
end
