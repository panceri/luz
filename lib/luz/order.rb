require 'luz/coupon'

module Luz
    class Order
        
        attr_accessor :id
        attr_accessor :coupon

        def initialize(id, coupon)
            @id = id;
            @coupon = coupon
        end
    end
end
