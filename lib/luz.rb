require "luz/version"
require "luz/coupon"
require "luz/product"
require "luz/order"
require "luz/result"
require "luz/csv_reader"
require "luz/csv_writer"
require 'luz/luz_log'
require 'csv'

module Luz
  class Principal

      def read_all(*args, reader: CSVReader.new)
        array = []
        args.each do |f|
          array << ["#{f.split(".")[0]}", reader.read(f)]
        end
        array
      end
      
      def populate(array)
        orders = []
        coupons = []
        products = []
        
        array.each do |obj|
          case obj[0]
            when "coupons"
              obj[1].each do |c|
                coupons << Coupon.new(c)
              end
            when "products"
              obj[1].each do |p|
                products << Product.new(p)
              end
            when "orders"
              obj[1].each do |o|
                coupon = coupons.find {|c| c.id == o[1].to_i}
                orders << Order.new(o[0], coupon)
              end
            when "order_items"
              obj[1].each do |od|
                order = orders.find {|o| o.id == od[0].to_i }
                product = products.find{|p| p.id == od[1].to_i}
                if order and product
                  order.add_product product 
                end
              end
          end
        end
        orders
      end
      
      def calculate(orders)
        results = []
        orders.each do |order|
          results << Result.new(order.id, order.total)
        end
        results
      end
      
      def write_result(results, output, writer: CSVWriter.new)
        results.each do |result|
          writer.write(output, [result.order_id, result.total]);
        end
        LuzLog.log.info "Done"
      end
  end
end
  