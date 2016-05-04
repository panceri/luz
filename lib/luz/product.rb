module Luz
    class Product

      attr_accessor :id, :price
        def initialize(array)
            @id = array[0].to_i
            @price = array[1].to_f
        end
    end
end
