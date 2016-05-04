require 'spec_helper'
require "luz/order_product"

describe Luz::OrderProduct do
	context "valid order" do
		it "coupon with absolut discount" do
			order = FactoryGirl.build(:order_product_absolute)
        	expect(order.total).to eq(25)
		end

		it "coupon with percent discount" do
			order = FactoryGirl.build(:order_product_percent)
        	expect(order.total).to eq(37.5)
		end

		it "without coupon" do
			order = FactoryGirl.build(:order_product_no_coupon)
        	expect(order.total).to eq(37.5)
		end
	end
end