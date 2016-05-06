require 'csv'

module Luz
    class CSVWriter
        def write(name, content)
            begin
              CSV.open(name, "a+") do |c|
                  c << content
              end
            rescue Exception => e
              puts "Error during write result, so i print to you"
              LuzLog.log.error "Error during write result, so i print to you"
              LuzLog.log.error e
            end
        end
    end
end
