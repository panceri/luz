require 'spec_helper'
require "luz/coupon"

describe Luz::Coupon do
    context "invalid arguments" do
        it "with least than 5 args" do
            expect { Luz::Coupon.new([0,1,2,3])}.to raise_error(ArgumentError, 'Wrong input size')
        end

        it "discount type " do
            expect { Luz::Coupon.new([0,1,2,3,4])}.to raise_error(ArgumentError, 'Invalid discount type')
        end

        it "date " do
            expect { Luz::Coupon.new([0,1,"percent",3,4])}.to raise_error(ArgumentError, 'invalid date')
        end

        it "Qtd " do
            expect { Luz::Coupon.new([0,1,"percent",3,"A"])}.to raise_error(ArgumentError, 'qtd must be a number')
        end

    end
    
    context "valid arguments" do

        it "coupon" do
           luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2020", 1])
           expect(luz.valid?).to be_truthy
        end
        
        it "invalid coupon (used lot of times)" do
           luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2020", 1])
           luz.mark_used
           expect(luz.valid?).to be_falsey
        end
        
        it "invalid coupon (used lot of times)" do
           luz = Luz::Coupon.new([123, 25, "absolute", '05/04/2016', 1])
           luz.mark_used
           expect(luz.valid?).to be_falsey
        end
        
        context "discount" do
            context "absolute" do
                it "regular" do
                   luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2020", 1])
                   expect(luz.calculate_discount(100)).to eq(75)
                end
                
                it "greater than value" do
                   luz = Luz::Coupon.new([123, 110, "absolute", "12/25/2020", 1])
                   expect(luz.calculate_discount(100)).to eq(0)
                end
            end
            
            context "percent" do

               it "regular" do
                   luz = Luz::Coupon.new([123, 10, "percent", "12/25/2020", 1])
                   expect(luz.calculate_discount(100)).to eq(90)
               end

               it "greater than 100%" do
                   luz = Luz::Coupon.new([123, 110, "percent", "12/25/2020", 1])
                   expect(luz.calculate_discount(100)).to eq(0)
               end
            end
            
            context "full" do
                context "absolute" do
                    it "regular" do
                       luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2020", 1])
                       expect(luz.apply_discount(100)).to eq(75)
                       expect(luz.valid?).to be_falsey
                    end
                    it "invalid coupon (used lot of times)" do
                       luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2020", 1])
                       luz.mark_used
                       expect(luz.apply_discount(100)).to eq(100)
                       expect(luz.valid?).to be_falsey
                    end
                    it "invalid coupon (invalid date)" do
                       luz = Luz::Coupon.new([123, 25, "absolute", "12/25/2015", 1])
                       luz.mark_used
                       expect(luz.apply_discount(100)).to eq(100)
                       expect(luz.valid?).to be_falsey
                    end
                end
                
                context "percent" do
                    it "regular" do
                       luz = Luz::Coupon.new([123, 25, "percent", "12/25/2020", 1])
                       expect(luz.apply_discount(100)).to eq(75)
                       expect(luz.valid?).to be_falsey
                    end
                    it "invalid coupon (used lot of times)" do
                       luz = Luz::Coupon.new([123, 25, "percent", "12/25/2020", 1])
                       luz.mark_used
                       expect(luz.apply_discount(100)).to eq(100)
                       expect(luz.valid?).to be_falsey
                    end
                    it "invalid coupon (invalid date)" do
                       luz = Luz::Coupon.new([123, 25, "percent", "12/25/2015", 1])
                       luz.mark_used
                       expect(luz.apply_discount(100)).to eq(100)
                       expect(luz.valid?).to be_falsey
                    end
                end
            end
        end
    end
end
