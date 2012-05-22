require 'spec_helper'

include Parsely::Person::NameConstants

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
      Parsely::Person::Name.new("Last, First").sanitized.should == "First Last"
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
  
  describe '#parse_name' do
    it 'should return the name without title or suffix' do
      Parsely::Person::Name.new("Mr. John Smith Jr.").parse_name.should == "John Smith"
      Parsely::Person::Name.new("John Smith").parse_name.should == "John Smith"
      Parsely::Person::Name.new("John Edward Smith").parse_name.should == "John Edward Smith"
    end
  end
  
  describe '#first' do
    it 'returns the first name' do
      Parsely::Person::Name.new("First1 Last").first.should == "First1"
      Parsely::Person::Name.new("First2 Middle Last").first.should == "First2"
      Parsely::Person::Name.new("First3 M M Last").first.should == "First3"
      Parsely::Person::Name.new("Last, First4").first.should == "First4"
    end
  end
  
  describe '#last' do
    it 'returns the last name' do
      Parsely::Person::Name.new("First Last1").last.should == "Last1"
      Parsely::Person::Name.new("First Middle Last2").last.should == "Last2"
      Parsely::Person::Name.new("First M M Last3").last.should == "Last3"
      Parsely::Person::Name.new("Last4, First").last.should == "Last4"
    end
  end
  
  describe '#middle' do
    it 'returns the middle name' do
      Parsely::Person::Name.new("First Last1").middle.should == ""
      Parsely::Person::Name.new("First Middle Last2").middle.should == "Middle"
      Parsely::Person::Name.new("First M M Last3").middle.should == "M M"
      Parsely::Person::Name.new("Last4, First").middle.should == ""
    end
  end
  
  describe '#name' do
    it 'returns the full name properly formatted' do
      Parsely::Person::Name.new("First Last").name.should == "First Last"
      Parsely::Person::Name.new("first last").name.should == "First Last"
      Parsely::Person::Name.new("Mr. First Last").name.should == "Mr. First Last"
      Parsely::Person::Name.new("First Last Jr.").name.should == "First Last Jr."
      Parsely::Person::Name.new("Last, First").name.should == "First Last"
    end
  
    context 'when proper is not specified' do
      it 'returns the name' do
        Parsely::Person::Name.new("First Last", :proper => false).name.should == "First Last"
        Parsely::Person::Name.new("first last", :proper => false).name.should == "first last"
        Parsely::Person::Name.new("Mr. First Last", :proper => false).name.should == "Mr. First Last"
        Parsely::Person::Name.new("First Last jr.", :proper => false).name.should == "First Last jr."
        Parsely::Person::Name.new("Last, First", :proper => false).name.should == "First Last"
      end
    end
  end
  
  describe '#to_hash' do
    it 'returns a hash of the name parts' do
      Parsely::Person::Name.new("First Last").to_hash.should == {:title => "", :first => "First", :middle => "", :last => "Last", :suffix => ""}
      Parsely::Person::Name.new("Mr. First Last").to_hash.should == {:title => "Mr.", :first => "First", :middle => "", :last => "Last", :suffix => ""}
      Parsely::Person::Name.new("First Last Jr.").to_hash.should == {:title => "", :first => "First", :middle => "", :last => "Last", :suffix => "Jr."}
      Parsely::Person::Name.new("Last, First").to_hash.should == {:title => "", :first => "First", :middle => "", :last => "Last", :suffix => ""}
      Parsely::Person::Name.new("Mr. First Middle Last Jr.").to_hash.should == {:title => "Mr.", :first => "First", :middle => "Middle", :last => "Last", :suffix => "Jr."}
    end
  end
  
  describe '#[]' do
    let!(:parser) { Parsely::Person::Name.new("Mr. First Middle Last Jr.") }
    
    it 'returns the correct value' do
      parser[:title].should == 'Mr.'
      parser[:first].should == 'First'
      parser[:middle].should == 'Middle'
      parser[:last].should == 'Last'
      parser[:suffix].should == 'Jr.'
    end
  end
end
