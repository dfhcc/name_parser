require 'spec_helper'
require 'ruby-debug'

include NameParser

Parser.send(:public, *Parser.protected_instance_methods)

describe Parser do
  let(:name) { 'Horatio Xavier Hornblower' }
  let(:parser) { Parser.new(name) }

  [:name, :first, :middle, :last, :title, :suffix ].each do |attr|
    describe "#{attr} attribute" do 
      it 'is read only' do
        parser.methods.should_not include(":#{attr}=") 
      end
    end
  end

  describe 'name attribute' do
    it 'is set on initialize' do
      get_name.should == name 
    end
  end

 describe '#to_hash' do
   it 'returns title, first, middle, last and suffix attributes as hash' do
     set_name('Major Peter X. Q Mac Donovan, Jr.')
     expected = { :title => 'Major', :first => 'Peter', :middle => 'X Q', :last => 'Mac Donovan', :suffix => 'Jr.' }

     parser.to_hash.should == expected
   end
   
   it 'calls run only once' do
    parser.should_receive(:run).once
    2.times { parser.to_hash }
   end
  end

  describe '#remove_non_name_characters' do
    it 'only allows alpha-numerics, dashes, backslashes, apostrophes and ampersands' do
      set_name("aZ1/&'`!@$#%^*()_+=[]{}|\:;""")
      parser.remove_non_name_characters

      get_name.should == "aZ1/&'"
    end
  end

  describe '#remove_extra_spaces' do
    it 'removes leading spaces, tabs and line breaks' do
      set_name(" \t\nFoo")

      parser.remove_extra_spaces.should == 'Foo'
    end
    it 'removes trailing spaces, tabs and line breaks' do
      set_name("Foo \t\n")

      parser.remove_extra_spaces.should == 'Foo'
    end
    it 'replaces repeating spaces, tabs and line breaks with a single space' do
      set_name("  Foo  \t\nBar  ")

      parser.remove_extra_spaces.should == 'Foo Bar'
    end
  end

  describe '#clean_trailing_suffixes' do
    it 'removes trailing suffixes' do
      set_name('Biggie Smalls, Junior, Esquire, Phd., VII')
      parser.clean_trailing_suffixes

      get_name.should == 'Biggie Smalls, Junior, Esquire, Phd. VII'
    end
  end

  describe '#reverse_last_and_first_names' do
    it 'reorders last and first names if comma is present' do
      set_name('Smith, Johnny')
      parser.reverse_last_and_first_names

      get_name.should == 'Johnny ;Smith'
    end
  end

  describe '#remove_commas' do
    it 'removes all commas' do
      set_name('Hounddog ;Taylor,')
      parser.remove_commas

      get_name.should == 'Hounddog ;Taylor'
    end
  end

  describe '#parse_title' do
    context 'when a title is found' do
      before { set_name('Colonel Henry Potter') }

      it 'sets title attribute' do
        parser.parse_title
        parser.title.should == 'Colonel'
      end
      it 'removes the title from name' do
        parser.parse_title

        get_name.should == 'Henry Potter'
      end
    end

    context 'when a title is not found' do
      it 'returns nil' do
        set_name('Frank Burns')
        
        parser.parse_title
        parser.title.should be_nil
      end
    end
  end

  describe '#parse_suffix' do
    context 'when a suffix is found' do
      before { set_name('Bubba Watson Jr.') }

      it 'returns the suffix' do
        parser.parse_suffix
        parser.suffix.should == 'Jr.'

      end
      it 'removes the suffix from name' do
        parser.parse_suffix

        get_name.should == 'Bubba Watson'
      end
    end

    context 'when a suffix is not found' do
       it 'returns nil' do
         set_name('Bubba Watson')

         parser.parse_suffix
         parser.suffix.should be_nil
       end
    end
  end

  describe '#parse_name' do
    context 'when first initial and last name' do
      before do 
        set_name('J Tolkien')
        parser.parse_name
      end

      it 'returns first initial' do
        parser.first.should == 'J' 
      end

      it 'returns nil middle name' do
        parser.middle.should be_nil
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first initial, middle initial and last name' do
      before do
        set_name('J R Tolkien')
        parser.parse_name
      end

      it 'returns first initial' do
        parser.first.should == 'J' 
      end

      it 'returns middle initial' do
        parser.middle.should == 'R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first initial dot middle initial dot last name' do
      before do
        set_name('J. R. Tolkien')
        parser.parse_name
      end

      it 'returns first initial' do
        parser.first.should == 'J' 
      end

      it 'returns middle initial' do
        parser.middle.should == 'R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first initial, two middle initials and last name' do
      before do
        set_name('J R R Tolkien')
         parser.parse_name
      end

      it 'returns first initial' do
        parser.first.should == 'J' 
      end

      it 'returns both middle initials' do
        parser.middle.should == 'R R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end

    end

    context 'when first initial, middle name and last name' do
      before do
        set_name('J Ronald Tolkien')
        parser.parse_name
      end

      it 'returns first initial' do
        parser.first.should == 'J' 
      end

      it 'returns middle name' do
        parser.middle.should == 'Ronald'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first name, middle initial and last name' do
      before do
        set_name('John R Tolkien')
         parser.parse_name
      end

      it 'returns first name' do
        parser.first.should == 'John' 
      end

      it 'returns middle initial' do
        parser.middle.should == 'R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first name, two middle initials and last name' do
      before do
        set_name('John R R Tolkien')
        parser.parse_name
      end

      it 'returns first name' do
        parser.first.should == 'John' 
      end

      it 'returns middle name' do
        parser.middle.should == 'R R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first name, two middle initials with dots and last name' do
      before do
        set_name('John R. R. Tolkien')
         parser.parse_name
      end

      it 'returns first name' do
        parser.first.should == 'John' 
      end

      it 'returns middle name' do
        parser.middle.should == 'R R'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first name and last name' do
      before do 
        set_name('John Tolkien')
        parser.parse_name
      end

      it 'returns first name' do
        parser.first.should == 'John' 
      end

      it 'returns nil middle name' do
        parser.middle.should be_nil
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when first name, middle name and last name' do
      before do 
        set_name('John Ronald Tolkien')
        parser.parse_name
      end

      it 'returns first name' do
        parser.first.should == 'John' 
      end

      it 'returns  middle name' do
        parser.middle.should == 'Ronald'
      end

      it 'returns last name' do
        parser.last.should == 'Tolkien'
      end
    end

    context 'when last name is hyphenated' do
      it 'returns last name' do
        set_name('John R. Tolkien-Smith')
        parser.parse_name
        parser.last.should == 'Tolkien-Smith'
      end

    end

    context 'when last name is preceded by a semicolon' do
      it 'returns last name' do 
        set_name('J R R ;Tolkien')
        parser.parse_name
        parser.last.should == 'Tolkien'
      end
    end

  end

  def set_name(name)
    parser.instance_variable_set(:@name, name)
  end

  def get_name
    parser.instance_variable_get(:@name)
  end
end
