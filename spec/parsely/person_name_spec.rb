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

  describe 'couple attribute' do
    it 'is read only' do
      ppn.methods.should_not include(:couple=)
    end

    it 'defaults to false' do
      ppn.couple.should be_false
    end

    it 'is set through options argument' do
      ppn = Parsely::PersonName.new(name, { :couple => true })

      ppn.couple.should be_true
    end

    it 'has an alias #couple?' do
      ppn.couple.should == ppn.couple?
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

  describe '#clean_marriage_titles' do
    it 'replaces ampersand in married couple titles' do 
      set_name('Mr. & Mrs. Harvey Birdman')
      ppn.clean_marriage_titles

      ppn.name.should == 'Mr. and Mrs. Harvey Birdman'
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

      it 'returns the title' do
        ppn.get_title.should == 'Colonel '
      end
      it 'removes the title from name' do
        ppn.get_title

        ppn.name.should == 'Henry Potter'
      end
    end

    context 'when a title is not found' do
      it 'returns nil' do
        set_name('Frank Burns')
        
        ppn.get_title.should be_nil
      end
    end
  end

  describe '#get_suffix' do
    context 'when a suffix is found' do
      before { set_name('Bubba Watson Jr.') }

      it 'returns the suffix' do
        ppn.get_suffix.should == 'Jr.'

      end
      it 'removes the suffix from name' do
        ppn.get_suffix

        ppn.name.should == 'Bubba Watson'
      end
    end

    context 'when a suffix is not found' do
       it 'returns nil' do
         set_name('Bubba Watson')

         ppn.get_suffix.should be_nil
       end
    end
  end

  def set_name(name)
    ppn.instance_variable_set(:@name, name)
  end

end
