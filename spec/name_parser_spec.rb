require 'spec_helper'

class TestClass
  include NameParser
end

describe NameParser do
  let!(:name) { "Adams, John Quincy" }
  let!(:test_class) { TestClass.new }

  describe '#name_parser' do
    it 'returns a new NameParser::Parser object' do
      test_class.name_parser(name).class.should == NameParser::Parser
    end

    it 'should run the parser' do
      parser = test_class.name_parser(name)
      parser.first.should == 'John'
      parser.middle.should == 'Quincy'
      parser.last.should == 'Adams'
    end
  end
end
