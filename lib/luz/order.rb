require 'luz/coupon'

module Luz
    class Order
        
        attr_accessor :id
        attr_accessor :coupon

        def initialize(id, coupon = nil)
            @id = id.to_i;
            @coupon = coupon
        end
    end
end
