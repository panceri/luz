require "luz/coupon"
require "luz/product"
require "luz/order_product"
require "luz/order"

module Luz
    FactoryGirl.define do
      factory :coupon, class: Coupon do
        id = 1
        value = 25
        type = "absolute"
        date = "12/25/2020"
        qtd = 1

        initialize_with { new([id, value, type, date, qtd]) }
      end
      
      factory :product, class: Product do
        id = 1
        price = 10.0

        initialize_with { new([id, price]) }
      end
      
      factory :order, class: Order do
        id = 1
        

        #initialize_with { new([id, price]) }
      end

      
     factory :order_product, class: OrderProduct do
        id = 1
        value = 25
        type = "absolute"
        date = "12/25/2020"
        qtd = 1

        initialize_with { new([id, value, type, date, qtd]) }
      end


    end
end