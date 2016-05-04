require 'csv'

module Luz
    class Parser
        def parse(file)
            CSV.read(file)
        end
    end
end
