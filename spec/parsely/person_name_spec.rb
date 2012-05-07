require 'parsely'

describe Parsely::PersonName do
  let(:name) { 'Horatio Xavier Hornblower' }
  let(:ppn) { Parsely::PersonName.new(name) }

  describe 'name attribute' do 
    it 'is read only' do
      ppn.methods.should_not include(:name=) 
    end

    it 'is set on initialize' do
      ppn.name.should == name 
    end

    it 'is shallow copy of original attr' do
      ppn.name.should == ppn.original
      ppn.instance_variable_set(:@name, 'changed')
      ppn.name.should_not == ppn.original
    end

  end

  describe 'original attribute' do
    it 'is read only' do
      ppn.methods.should_not include(:original=)
    end

    it 'is set on initialize' do
      ppn.original.should == name
    end
  end

  describe '#clean' do
    after do
      ppn.clean
    end

    it 'calls #remove_illegal_characters' do
      ppn.should_receive(:remove_illegal_characters)
    end

    it 'calls #remove_repeating_spaces' do
      ppn.should_receive(:remove_repeating_spaces)
    end
    
    it 'calls #remove_leading_and_trailing_spaces' do
      ppn.should_receive(:remove_leading_and_trailing_spaces)
    end
  end

  describe '#remove_illegal_characters' do
    it 'only allows alpha-numerics, dashes, backslashes, apostrophes and ampersands' do
      ppn.instance_variable_set(:@name, "aZ1/&'`!@$#%^*()_+=[]{}|\:;""")
      ppn.remove_illegal_characters
      ppn.name.should == "aZ1/&'"
    end
  end

  describe '#remove_repeating_spaces' do
    it 'replaces all repeating spaces, tabs and line breaks with a single space' do
      ppn.instance_variable_set(:@name, "a  b   c\td\n")
      ppn.remove_repeating_spaces.should == 'a b c d '
    end
  end

  describe '#remove_leading_and_trailing_spaces' do

    it 'removes leading and trailing spaces' do
      ppn.instance_variable_set(:@name, ' a ')
      ppn.remove_leading_and_trailing_spaces
      ppn.name.should == 'a'
    end

  end

end
