require 'csv'

module Luz
    class CSVReader
        def read(file)
            CSV.read(file)
        end
    end
end
