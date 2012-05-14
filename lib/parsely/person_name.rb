require 'parsely/person_name_constants'

module Parsely
  class PersonName
    include PersonNameConstants

    attr_reader :first, :middle, :last, :title, :suffix

    def initialize(name)
      @name = name.dup
    end

    def to_hash
      run
      [ :title, :first, :middle, :last, :suffix ].inject(Hash.new) { |h, attr| h.merge!(attr => send(attr)) }
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

    protected

    def remove_illegal_characters
      @name.gsub!(/[^A-Za-z0-9\-\'\.&\/ \,]/, '')
    end

    def remove_repeating_spaces
      @name.gsub!(/\s+/, ' ')
    end

    def strip_spaces 
      @name.strip!
    end

    def clean_trailing_suffixes
      SUFFIXES.each do |suffix|
        @name.gsub!( Regexp.new("(.+), (#{suffix})$", true ), "\\1 \\2" )
      end
    end

    def reverse_last_and_first_names
      @name.gsub!(/;/, '')
      @name.gsub!(/(.+),(.+)/, "\\2 ;\\1")
    end

    def remove_commas
      @name.gsub!(/,/, '')
    end

    def parse_title
      TITLES.each do |title|
        if match = @name.match(Regexp.new("^(#{title})(.+)", true))
          @name = match[-1]
          @title = match[1].strip
        end
      end
    end

    def parse_suffix
      SUFFIXES.each do |suffix|
        if match = @name.match(Regexp.new("(.+) (#{suffix})$", true))
          @name = match[1].strip
          @suffix = match[2]
        end
      end
    end

    def parse_name
      case
        when match = @name.match(Regexp.new('^%s%s$' % [ NAME_PATTERN, LAST_NAME_PATTERN ], true))
          @first, @last = match.captures
        when match = @name.match(Regexp.new('^%s%s%s%s$' % [ NAME_PATTERN, NAME_PATTERN, NAME_PATTERN, LAST_NAME_PATTERN ], true))
          @first, *middles, @last = match.captures[0..3]
          @middle = middles.join(' ')
        when match = @name.match(Regexp.new('^%s%s%s$' % [ NAME_PATTERN, NAME_PATTERN, LAST_NAME_PATTERN ], true))
          @first, @middle, @last = match.captures
      end
    end

  end
end
