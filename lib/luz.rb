require "luz/version"
require "luz/coupon"
require "luz/product"
require "luz/order"
require "luz/order_product"
require 'csv'

module Luz
  class Principal

      def initialize(arg1, arg2, arg3, arg4, arg5)
        coupons, products, orders, order_produts = Array.new
        
        read_csv(arg1).foreach do |row|  
          coupons.push(new Coupon(row))
        end
        
        read_csv(arg2).foearch do |row| 
          products.push(new Product(row))
        end
        
        #fill order with id and coupon
        orders = read_csv(arg3).foreach do |row| 
          orders.push(new Order(row[0], coupons.select {|c| c.id = row[1]}.first))
        end
        
        read_csv(arg4).foreach do |row|
          if order_products.count{ |o| o.order.id == row[0]  } == 0
            order_products.push(new ProductOrder(orders.detect{|d| i == row[0]}))
          end

          order_product = order_products.select{ |o| o.order.id == row[0]}.first
          order_product.add_product(products.select{|p| p.id == row[1]}.first)
        end
      end
      
      def result
        puts "Works"
      end

      private

      def read_csv(name)
        CSV.read(name)
      end
  end
end
