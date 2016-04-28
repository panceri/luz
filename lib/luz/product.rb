module Luz
    class Product
        def initialize(array)
            @id, @price = array.split(",")
        end
    end
end