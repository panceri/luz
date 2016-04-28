require 'date'
module Luz
    class Coupon
        @@used_times = 0
        
        def initialize(array)
            @id, @value, @type, @date, @qtd = array.split(",")
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
                when 'absolute' (value > @value) ? value - @value : 0 #negative values dont exists
                when 'percent' (@value <= 100) ? value - ((value * @value) / 100) : 0
            end

        end
    end 
end