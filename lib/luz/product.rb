module Luz
    class Product

      attr_accessor :id, :price
        def initialize(array)
            @id = array[0]
            @price = array[1]
        end
    end
end
