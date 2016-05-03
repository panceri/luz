require 'date'
module Luz
    class Coupon
        @@used_times = 0
        attr_accessor :id, :value, :type, :date, :qtd

        def initialize(array)
            @id = array[0]
            @value = array[1]
            @type = array[2]
            @date = array[3]
            @qtd = array[4]
        end

        def to_s
            puts "ID: #{@id}"
            puts "Value: #{@value}"
            puts "Type: #{@type}"
            puts "Date: #{@date}"
            puts "Qtd: #{@qtd}"
        end

        def mark_used
            @@used_times += 1
        end

        def valid?
           return ((@@used_times < @qtd) and (Datetime.parse(@date) < Datetime.now))
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
                when 'absolute' return (value > @value) ? value - @value : 0 #negative values dont exists
                when 'percent' return (@value <= 100) ? value - ((value * @value) / 100) : 0
            end

        end
    end
end
