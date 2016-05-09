require 'luz/luz_log'

module Luz
    class Result
      attr_accessor :order_id, :total

        def initialize(id, total)
            @order_id = id
            @total = total
        end

        def to_a
          [@order_id, @total]
        end
    end
end
