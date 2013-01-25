module NameParser
  class Parser
    include Patterns

    attr_reader :first, :middle, :last, :title, :suffix

    def initialize(name)
      @name = name.dup
      run
    end

    protected

      def run
        remove_non_name_characters
        remove_extra_spaces
        clean_trailing_suffixes
        reverse_last_and_first_names
        remove_commas
        parse_title
        parse_suffix
        parse_name
      end

      def remove_non_name_characters
        @name.gsub!(/[^A-Za-z0-9\-\'\.&\/ \,]/, '')
      end

      def remove_extra_spaces
        @name.gsub!(/\s+/, ' ')
        @name.strip!
      end

      def clean_trailing_suffixes
        @name.gsub!(Regexp.new("(.+), (%s)$" % SUFFIX_PATTERN, true), "\\1 \\2")
      end

      def reverse_last_and_first_names
        @name.gsub!(/;/, '')
        @name.gsub!(/(.+),(.+)/, "\\2 ;\\1")
        @name.strip!
      end

      def remove_commas
        @name.gsub!(/,/, '')
      end

      def parse_title
        if match = @name.match(Regexp.new("^(%s) (.+)" % TITLE_PATTERN, true))
          @name = match[-1]
          @title = match[1].strip
        end
      end

      def parse_suffix
        if match = @name.match(Regexp.new("(.+) (%s)$" % SUFFIX_PATTERN, true))
          @name = match[1].strip
          @suffix = match[2]
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