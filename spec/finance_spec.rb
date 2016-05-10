require 'spec_helper'
require "luz/finance"
require "luz/result"

describe Luz::Finance do
    #subject(:finance) { Luz::Finance.new }
    describe "#common_discount" do
        context "with 1 item" do
            it "returns the amount" do
                expect(subject.common_discount(10, 1)).to eq(10)
            end
        end
    
        context "with 2 itens" do
            it "returns the amount" do
                expect(subject.common_discount(10, 2)).to eq(9)
            end
        end
        
        context "with 9 itens" do
            it "returns the amount" do
                expect(subject.common_discount(10, 9)).to eq(6)
            end        
        end
    end
    
    describe "#calculate_coupon_discount" do
        context "with absolute coupon" do
            let(:absolute_coupon) { FactoryGirl.build(:coupon) }
            it "return correct amount" do
                expect(subject.calculate_coupon_discount(absolute_coupon, 50)).to eq(25)
            end
            
            it "return 0 when discount greater than amount" do
                expect(subject.calculate_coupon_discount(absolute_coupon, 20)).to eq(0)
            end
        end
        
        context "with percent coupon" do
            let(:percent_coupon) { FactoryGirl.build(:coupon, discount: 10, type: "percent") }
            
            it "return correct amount" do 
                expect(subject.calculate_coupon_discount(percent_coupon, 20)).to eq(18)
            end

            it "return 0 when discount greater than equal 100%" do
                percent_coupon.discount = 101
                expect(subject.calculate_coupon_discount(percent_coupon, 20)).to eq(0)
            end
        end
        
        context "without coupon" do
            it "return correct amount" do 
                expect(subject.calculate_coupon_discount(nil, 20)).to eq(20)
            end
        end
    end
    
    describe "#total" do
        let(:products) {FactoryGirl.build_list(:product, 5)}
        context "with valid absolute coupon" do
            let(:absolute_coupon) { FactoryGirl.build(:coupon) }
            
            it "return total of order" do
                expect(subject.total(products, absolute_coupon)).to eq(25)
            end
        end
        
        context "with invalid absolute coupon" do
            let(:absolute_coupon) { FactoryGirl.build(:coupon, qtd: 0) }
            
            it "return total of order (using common_discount)" do
                expect(subject.total(products, absolute_coupon)).to eq(37.5)
            end
        end
        
        context "with valid percent coupon" do 
            let(:percent_coupon) { FactoryGirl.build(:coupon, discount: 35, type: "percent") }
            
            it "return total of order" do
                expect(subject.total(products, percent_coupon)).to eq(32.5)
            end
        end
        
        context "with invalid percent coupon" do 
            let(:percent_coupon) { FactoryGirl.build(:coupon, discount: 35, type: "percent", qtd: 0) }
            
            it "return total of order (using common_discount)" do
                expect(subject.total(products, percent_coupon)).to eq(37.5)
            end
        end
        
        context "without coupon" do 

            it "return total of order (using common_discount)" do
                expect(subject.total(products, nil)).to eq(37.5)
            end
        end
    end
    
    describe "#calculate" do
        context "order with absolute coupon" do
            let(:order) { FactoryGirl.build(:order_absolute) }
            
            it "return Result object with amount and id" do
                results = subject.calculate([order])
                expect(results[0].to_a).to match_array([1, 25])
            end
        end

        context "order with percent coupon" do
            let(:order) { FactoryGirl.build(:order_percent) }
            
            it "return Result object with amount and id" do
                results = subject.calculate([order])
                expect(results[0].to_a).to match_array([1, 32.5])
            end
        end
        
        context "order without coupon" do
            let(:order) { FactoryGirl.build(:order_without_coupon) }
            
            it "return Result object with amount and id" do
                results = subject.calculate([order])
                expect(results[0].to_a).to match_array([1, 37.5])
            end
        end
    end
end