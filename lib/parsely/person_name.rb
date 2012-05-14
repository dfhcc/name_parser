require 'parsely/person_name_constants'

module Parsely
  class PersonName
    include PersonNameConstants

    attr_reader :original, :name
    attr_reader :first, :middle, :last, :title, :suffix

    def initialize(name)
      @name = name.dup
      @original = name
    end

    def run
      remove_illegal_characters
      remove_repeating_spaces
      strip_spaces
      clean_trailing_suffixes
      reverse_last_and_first_names
      remove_commas
      strip_spaces
      parse_title
      parse_suffix
      parse_name
    end

    def remove_illegal_characters
      name.gsub!(ILLEGAL_CHARACTERS, '')
    end

    def remove_repeating_spaces
      name.gsub!(REPEATING_SPACES, ' ')
    end

    def strip_spaces 
      name.strip!
    end

    def clean_trailing_suffixes
      SUFFIXES.each do |suffix|
        suffix_p = Regexp.new( "(.+), (#{suffix})$", true )
        name.gsub!( suffix_p, "\\1 \\2" )
      end
    end

    def reverse_last_and_first_names
      name.gsub!(/;/, '')
      name.gsub!(/(.+),(.+)/, "\\2 ;\\1")
    end

    def remove_commas
      name.gsub!(/,/, '')
    end

    def parse_title
      TITLES.each do |title|
        title_p = Regexp.new("^(#{title})(.+)", true)
        if match = name.match(title_p)
          @name = match[-1]
          @title = match[1].strip
        end
      end
    end

    def parse_suffix
      SUFFIXES.each do |suffix|
        suffix_p = Regexp.new("(.+) (#{suffix})$", true)
        if match = name.match(suffix_p)
          @name = match[1].strip
          @suffix = match[2]
        end
      end
    end

    def parse_name
      first_last_pattern               = Regexp.new('^%s%s$' % [ NAME_PATTERN, LAST_NAME_PATTERN ], true)
      first_middle_last_pattern        = Regexp.new('^%s%s%s$' % [ NAME_PATTERN, NAME_PATTERN, LAST_NAME_PATTERN ], true)
      first_middle_middle_last_pattern = Regexp.new('^%s%s%s%s$' % [ NAME_PATTERN, NAME_PATTERN, NAME_PATTERN, LAST_NAME_PATTERN ], true)

      case
        when match = name.match(first_last_pattern)
          @first, @last = match.captures
        when match = name.match(first_middle_middle_last_pattern)
          @first, *middles, @last = match.captures[0..3]
          @middle = middles.join(' ')
        when match = name.match(first_middle_last_pattern)
          @first, @middle, @last = match.captures
      end
    end

  end
end
