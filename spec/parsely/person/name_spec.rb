require 'spec_helper'
require 'parsely/person/name'

describe Parsely::Person::Name do

  describe '#original' do
    it 'should be the unaltered version of the initialized name' do
      name = "BlahBlah A. BlahBlah II"
      Parsely::Person::Name.new(name).original.should == name
    end
  end
  
  describe '#sanitized' do
    it 'should remove any illegal charaters' do
      Parsely::Person::Name.new("aZ1/&-'`!@$#%^*()_+=[]{}|\:;""").sanitized.should == "aZ1/&-'"
    end
    
    it 'should remove any extra spaces' do
      Parsely::Person::Name.new("a  b   c\td\n").sanitized.should == "a b c d"
    end
    
    it 'should remove any leading or trailing whitespaces' do
      Parsely::Person::Name.new(" A. NAME ").sanitized.should == "A. NAME"
    end
    
    it 'should clean marriage titles' do
      Parsely::Person::Name.new("Mr. & Mrs. George Washington").sanitized.should == "Mr. and Mrs. George Washington"
    end
    
    it 'should reverse last and first when the name format is "Last, First"' do
      Parsely::Person::Name.new("Last, First").sanitized.should == "First ;Last"
    end
    
    it 'should remove any unnecessary commas' do
      Parsely::Person::Name.new("George Washington,").sanitized.should == "George Washington"
    end
    
    context 'the couple option is set to true' do
      it 'replaces "and" with "&" when two names are specified' do
        Parsely::Person::Name.new("George Washington and John Adams", :couple => true).sanitized.should == "George Washington & John Adams"
      end
    end
  end
  
  describe '#couple?' do
    it 'should be false when the option is not specified' do
      Parsely::Person::Name.new("Some Name").should_not be_couple
    end
    
    it 'should be true when the option is set to true' do
      Parsely::Person::Name.new("Some Name", :couple => true).should be_couple
    end
    
    it 'should be false when the option is set to false' do
      Parsely::Person::Name.new("Some Name", :couple => false).should_not be_couple
    end
  end
  
  describe '#proper?' do
    it 'should be true when the option is not specified' do
      Parsely::Person::Name.new("Some Name").should be_proper
    end
    
    it 'should be true when the option is set to true' do
      Parsely::Person::Name.new("Some Name", :proper => true).should be_proper
    end
    
    it 'should be false when the option is set to false' do
      Parsely::Person::Name.new("Some Name", :proper => false).should_not be_proper
    end
  end
  
  describe '#title' do
    context 'given a name wihtout a title' do
      it 'returns a blank string' do
        Parsely::Person::Name.new("Ringo Starr").title.should == ''
      end
    end
    
    context 'given a name with a title' do
      it 'should return the title' do
        Parsely::Person::Name.new("Dr. Winston O'Boogie").title.should == 'Dr.'
        Parsely::Person::Name.new("Sir Paul McCartney").title.should == 'Sir'
        Parsely::Person::Name.new('Mr. George Harrison').title.should == 'Mr.'
        Parsely::Person::Name.new("Mr. and Mrs. John Lennon").title.should == "Mr. and Mrs."
      end
    end
  end
  
  describe '#suffix' do
    context 'given a name without a suffix' do
      it 'returns a blank string' do
        Parsely::Person::Name.new("John Adams").suffix.should == ''
      end
    end
    
    context 'given a name with a suffix' do
      it 'returns string of the suffix' do
        Parsely::Person::Name.new("John Adams Jr.").suffix.should == "Jr."
        Parsely::Person::Name.new("Gregory House M.D.").suffix.should == "M.D."
      end
    end
  end
end
