require "luz/coupon"
require "luz/product"
require "luz/order_product"
require "luz/order"

module Luz
    FactoryGirl.define do
      factory :coupon, class: Coupon, :aliases => [:absolute_coupon] do
        id = 1
        discount = 25
        type = "absolute"
        date = "2020/12/25"
        qtd = 1

        initialize_with { new([id, discount, type, date, qtd]) }
      end
      
      factory :product, class: Product, :aliases => [:default_product] do
        id = 1
        price = 10.0

        initialize_with { new([id, price]) }
      end
      
      factory :order, class: Order, :aliases => [:default_order] do
        id = 1

        trait :absolute do
          initialize_with { new(id, FactoryGirl.build(:absolute_coupon)) }
        end

        trait :percent do
          initialize_with { new(id, FactoryGirl.build(:absolute_coupon, type: "percent")) }
        end

        trait :no_coupon do
          initialize_with { new(id, nil) }
        end

        factory :order_absolute,   traits: [:absolute]
        factory :order_percent,    traits: [:percent]
        factory :order_without_coupon,    traits: [:no_coupon]
      end

      
     factory :order_product, class: OrderProduct do
        trait :absolute do
          initialize_with { new(FactoryGirl.build(:order_absolute)) }
        end

        trait :percent do
          initialize_with { new(FactoryGirl.build(:order_percent)) }
        end

        trait :no_coupon do
          initialize_with { new(FactoryGirl.build(:order_without_coupon)) }
        end


        factory :order_product_absolute,   traits: [:absolute]
        factory :order_product_percent,    traits: [:percent]
        factory :order_product_no_coupon,    traits: [:no_coupon]

        after(:build) do |o|
          5.times {o.add_product(FactoryGirl.build(:product))}  
        end
      end
    end
end