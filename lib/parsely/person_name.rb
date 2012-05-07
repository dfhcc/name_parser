module Parsely

  class PersonName

    ILLEGAL_CHARACTERS = /[^A-Za-z0-9\-\'\.&\/ \,]/
    REPEATING_SPACES = /\s+/

    attr_reader :name
    attr_reader :original
    
    def initialize(name)
      @name = name.dup
      @original = name
    end

    def clean
      remove_illegal_characters
      remove_repeating_spaces
      remove_leading_and_trailing_spaces
    end

    def remove_illegal_characters
      name.gsub!(ILLEGAL_CHARACTERS, '')
    end

    def remove_repeating_spaces
      name.gsub!(REPEATING_SPACES, ' ')
    end

    def remove_leading_and_trailing_spaces
      name.strip!
    end

  end

end
