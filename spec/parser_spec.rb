require 'spec_helper'
require "luz/parser"

RSpec.describe Luz::Parser do
   describe "parse" do
       let(:file_name) { "filename.csv" }
       let(:data) { "title\tsurname\tfirstname\rtitle2\tsurname2\tfirstname2\r"}
       let(:parsed) {[["title","surname","firstname"],["title2","surname2","firstname2"]] }
       it "should parse file contents and return a result" do
           allow(File).to receive(:read).with(file_name, 'r').and_return(data)
           
           parser = Luz::Parser.new
           expect(parser.parse(file_name)).to eq(parsed)
       end
   end
end