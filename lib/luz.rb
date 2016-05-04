require "luz/version"
require "luz/coupon"
require "luz/product"
require "luz/order"
require "luz/order_product"
require 'csv'

module Luz
  class Principal

      def initialize(arg1, arg2, arg3, arg4, arg5)
        coupons = Array.new
        products = Array.new
        orders = Array.new
        @order_products = Array.new
        @output = arg5
        
        CSV.foreach(arg1) do |row|  
          coupons << Coupon.new(row)
        end

        CSV.foreach(arg2) do |row|  
          products << Product.new(row)
        end

        CSV.foreach(arg3) do |row|  
          coupon = coupons.select {|c| c.id = row[1]}.first
          orders << Order.new(row[0], coupon)
        end

        CSV.foreach(arg4) do |row|  
          order_product = @order_products.find {|o| o.order.id == row[0] }
          if order_product
          else
            order =  orders.find{|d| d.id == row[0]}
            @order_products.push OrderProduct.new(order)
          end

          order_product = @order_products.find{ |o| o.order.id == row[0]}
          order_product.add_product(products.find{|p| p.id == row[1]})        
        end

      end

      def result
        #write_results(@output, calculate(@order_products))
        puts calculate(@order_products)
      end
      
      private
    
      def calculate(order_products)
        result = []
        order_products.each do |o|
          result.push("#{o.order.id},#{o.total}")
        end
        result
      end
      
      def write_results(csv, results)
        CSV.open(csv, "w") do |c|
          c << results
        end
      end
  end
end
