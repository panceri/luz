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
        
    end
end
