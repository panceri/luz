require 'date'
module Luz
    class Coupon

        attr_accessor :id, :discount, :type, :date, :qtd

        def initialize(array)
            raise ArgumentError, 'Wrong input size' unless array.size == 5
            raise ArgumentError, 'Invalid discount type' unless array[2].to_s.match(/(percent|absolute)/)
            raise ArgumentError, 'qtd must be a number' unless array[4].to_s.match(/^[0-9]+$/)

            @id = array[0].to_i
            @discount = array[1].to_f
            @type = array[2].to_s
            @date = Date.strptime(array[3].to_s, "%Y/%m/%d")
            @qtd = array[4].to_i
            @used_times = 0
        end

        def mark_used
            @used_times += 1
        end

        def valid?
           return ((@used_times < @qtd) and (@date > Date.today))
        end
        
    end
end
