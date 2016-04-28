module Luz
    class Product
        def initialize(array, delimiter)
            @id, @price = array.split(delimiter)
        end
    end
end