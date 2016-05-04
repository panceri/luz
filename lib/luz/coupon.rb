require 'date'
module Luz
    class Coupon

        attr_accessor :id, :value, :type, :date, :qtd

        def initialize(array)
            raise ArgumentError, 'Wrong input size' unless array.size == 5
            raise ArgumentError, 'Invalid discount type' unless array[2].to_s.match(/(percent|absolute)/)
            raise ArgumentError, 'qtd must be a number' unless array[4].to_s.match(/^[0-9]+$/)

            @id = array[0]
            @value = array[1].to_f
            @type = array[2].to_s
            @date = Date.strptime(array[3].to_s, "%Y/%m/%d")
            @qtd = array[4].to_f
            @used_times = 0
        end

        def to_s
            puts "ID: #{@id}"
            puts "Value: #{@value}"
            puts "Type: #{@type}"
            puts "Date: #{@date}"
            puts "Qtd: #{@qtd}"
        end

        def mark_used
            @used_times += 1
        end

        def valid?
           return ((@used_times < @qtd) and (@date > Date.today))
        end

        def apply_discount(value)
            if self.valid?
                self.mark_used
                return self.calculate_discount(value)
            else
                return value
            end
        end

        def calculate_discount(value)
            case @type
                when 'absolute' 
                    return (value > @value) ? value - @value : 0 #negative values dont exists
                when 'percent' 
                    return (@value <= 100) ? value - ((value * @value) / 100) : 0
            end

        end
    end
end
