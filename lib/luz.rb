require "luz/version"
require "luz/coupon"
require "luz/product"
require "luz/order"
require "luz/order_product"
require 'csv'

module Luz
  class Principal

      def initialize(*args)
        unless args.size == 5 and args.all?
          puts "Usage: luz coupons.csv products.csv orders.csv order_items.csv outuput.csv"
          exit 1
        end

        coupons = Array.new
        products = Array.new
        orders = Array.new
        @order_products = Array.new
        @output = args[4]
        
        CSV.foreach(args[0]) do |row|  
          coupons << Coupon.new(row)
        end

        CSV.foreach(args[1]) do |row|  
          products << Product.new(row)
        end

        CSV.foreach(args[2]) do |row|  
          coupon = coupons.find {|c| c.id == row[1].to_i}
          orders << Order.new(row[0], coupon)
        end
        
        CSV.foreach(args[3]) do |row|  
          order_product = @order_products.find {|o| o.order.id == row[0].to_i }
          if order_product
          else
            order =  orders.find{|d| d.id == row[0].to_i}
            @order_products.push OrderProduct.new(order)
          end

          order_product = @order_products.find{ |o| o.order.id == row[0].to_i}
          order_product.add_product(products.find{|p| p.id == row[1].to_i})        
        end

      end

      def result
        write_results(@output, calculate(@order_products))
        puts "Done"
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
        begin
          CSV.open(csv, "a+") do |c|
            results.each do |r|
              c << [r.split(",")[0], r.split(",")[1]]  
            end
          end
        rescue Exception => e
          puts "Error during write result, so i print to you"
          puts results
        end
      end
  end
end
  