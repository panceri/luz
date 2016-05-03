require "luz/coupon"

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
    end
end