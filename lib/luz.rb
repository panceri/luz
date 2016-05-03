require "luz/version"
require "luz/coupon"
require "luz/product"
require "luz/order"
require "luz/order_products"
require 'csv'

module Luz
  class Principal

      def initialize(arg1, arg2, arg3, arg4, arg5)
        coupons = read_csv(arg1).foearch do |row| { coupons << new Coupon(row)}
        products = read_csv(arg2).foearch do |row| { products << new Product(row)}
        orders = read_csv(arg3).foreach do |row| { orders << new Order(row)}
        order_products = read_csv(arg4) do |row| {

          if order_products.count{ |o| o.order.id == row[0]  } == 0
            order_products << new ProductOrder(orders.detect{|d| i == row[0]})
          end

          order_product = order_products.select{ |o| o.order.id == row[0]}.first
          order_product.add_product(products.select{|p| p.id == row[1]}.first)
        }

      end

      private

      def read_csv(name)
        CSV.read(name)
      end
  end
end
