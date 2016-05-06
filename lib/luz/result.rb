require 'luz/luz_log'

module Luz
    class Result
      attr_accessor :order_id, :total

        def initialize(id, total)
            @order_id = id
            @total = total
        end
    end
end
