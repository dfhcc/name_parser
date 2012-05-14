require 'parsely'
require 'ruby-debug'

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

      set_name('changed')

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

  describe '#remove_illegal_characters' do
    it 'only allows alpha-numerics, dashes, backslashes, apostrophes and ampersands' do
      set_name("aZ1/&'`!@$#%^*()_+=[]{}|\:;""")
      ppn.remove_illegal_characters

      ppn.name.should == "aZ1/&'"
    end
  end

  describe '#remove_repeating_spaces' do
    it 'replaces all repeating spaces, tabs and line breaks with a single space' do
      set_name("a  b   c\td\n")

      ppn.remove_repeating_spaces.should == 'a b c d '
    end
  end

  describe '#strip_spaces' do
    it 'removes leading and trailing spaces' do
      set_name(' a ')
      ppn.strip_spaces

      ppn.name.should == 'a'
    end
  end

  describe '#clean_trailing_suffixes' do
    it 'removes trailing suffixes' do
      set_name('Biggie Smalls, Junior, Esquire, Phd., VII')
      ppn.clean_trailing_suffixes

      ppn.name.should == 'Biggie Smalls, Junior, Esquire, Phd. VII'
    end
  end

  describe '#reverse_last_and_first_names' do
    it 'reorders last and first names if comma is present' do
      set_name('Smith, Johnny')
      ppn.reverse_last_and_first_names

      ppn.name.should == ' Johnny ;Smith'
    end
  end

  describe '#remove_commas' do
    it 'removes all commas' do
      set_name('Hounddog ;Taylor,')
      ppn.remove_commas

      ppn.name.should == 'Hounddog ;Taylor'
    end
  end

  describe '#get_title' do
    context 'when a title is found' do
      before { set_name('Colonel Henry Potter') }

      it 'sets title attribute' do
        ppn.get_title
        ppn.title.should == 'Colonel'
      end
      it 'removes the title from name' do
        ppn.get_title

        ppn.name.should == 'Henry Potter'
      end
    end

    context 'when a title is not found' do
      it 'returns nil' do
        set_name('Frank Burns')
        
        ppn.get_title
        ppn.title.should be_nil
      end
    end
  end

  describe '#get_suffix' do
    context 'when a suffix is found' do
      before { set_name('Bubba Watson Jr.') }

      it 'returns the suffix' do
        ppn.get_suffix
        ppn.suffix.should == 'Jr.'

      end
      it 'removes the suffix from name' do
        ppn.get_suffix

        ppn.name.should == 'Bubba Watson'
      end
    end

    context 'when a suffix is not found' do
       it 'returns nil' do
         set_name('Bubba Watson')

         ppn.get_suffix
         ppn.suffix.should be_nil
       end
    end
  end

  describe '#parse_name' do
    context 'when first initial and last name' do
      before do 
        set_name('J Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first initial' do
        @parts[0].should == 'J' 
      end

      it 'returns nil middle name' do
        @parts[1].should be_nil
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first initial, middle initial and last name' do
      before do
        set_name('J R Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first initial' do
        @parts[0].should == 'J' 
      end

      it 'returns middle initial' do
        @parts[1].should == 'R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first initial dot middle initial dot last name' do
      before do
        set_name('J. R. Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first initial' do
        @parts[0].should == 'J' 
      end

      it 'returns middle initial' do
        @parts[1].should == 'R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first initial, two middle initials and last name' do
      before do
        set_name('J R R Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first initial' do
        @parts[0].should == 'J' 
      end

      it 'returns both middle initials' do
        @parts[1].should == 'R R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end

    end

    context 'when first initial, middle name and last name' do
      before do
        set_name('J Ronald Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first initial' do
        @parts[0].should == 'J' 
      end

      it 'returns middle name' do
        @parts[1].should == 'Ronald'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first name, middle initial and last name' do
      before do
        set_name('John R Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first name' do
        @parts[0].should == 'John' 
      end

      it 'returns middle initial' do
        @parts[1].should == 'R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first name, two middle initials and last name' do
      before do
        set_name('John R R Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first name' do
        @parts[0].should == 'John' 
      end

      it 'returns middle name' do
        @parts[1].should == 'R R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first name, two middle initials with dots and last name' do
      before do
        set_name('John R. R. Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first name' do
        @parts[0].should == 'John' 
      end

      it 'returns middle name' do
        @parts[1].should == 'R R'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first name and last name' do
      before do 
        set_name('John Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first name' do
        @parts[0].should == 'John' 
      end

      it 'returns nil middle name' do
        @parts[1].should be_nil
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when first name, middle name and last name' do
      before do 
        set_name('John Ronald Tolkien')
        @parts = ppn.parse_name
      end

      it 'returns first name' do
        @parts[0].should == 'John' 
      end

      it 'returns  middle name' do
        @parts[1].should == 'Ronald'
      end

      it 'returns last name' do
        @parts[2].should == 'Tolkien'
      end
    end

    context 'when last name is hyphenated' do
      it 'returns last name' do
        set_name('John R. Tolkien-Smith')
        ppn.parse_name[2].should == 'Tolkien-Smith'
      end

    end

    context 'when last name is preceded by a semicolon' do
      it 'returns last name' do 
        set_name('J R R ;Tolkien')
        ppn.parse_name[2].should == 'Tolkien'
      end
    end

  end

  def set_name(name)
    ppn.instance_variable_set(:@name, name)
  end

end
