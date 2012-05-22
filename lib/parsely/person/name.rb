module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :original
      attr_reader :couple
      attr_reader :proper
      
      attr_reader :sanitized
      attr_reader :parse_name
      attr_reader :parse_type
      
      alias :couple? :couple
      alias :proper? :proper
      
      def initialize(name, opts={})
        @original  = name
        @sanitized = name.dup
        
        @couple    = opts[:couple].nil? ? false : opts[:couple]
        @proper    = opts[:proper].nil? ? true  : opts[:proper]
        
        sanitize
      end
      
      def name
        @name ||= build_name
      end
      alias :to_s :name
      
      def to_hash
        @hash ||= {:title => title, :first => first, :middle => middle, :last => last, :suffix => suffix}
      end
      
      def first
        @first ||= parse_first
      end
      
      def middle
        @middle ||= parse_middle
      end
      
      def last
        @last ||= parse_last
      end
      
      def title
        @title ||= parse_title
      end
      
      def suffix
        @suffix ||= parse_suffix
      end
      
      def parse_name
        @parse_name ||= sanitized.gsub(title, '').gsub(suffix, '').strip
      end
      
      def [](attr)
        self.send attr.to_sym
      end
      
      private
      
        def sanitize
          remove_repeating_spaces
          remove_illegal_characters
          format_for_multiple_names if couple?
          clean_marriage_titles
          format_first_last_name
          remove_commas
          strip_spaces
        end
        
        def remove_illegal_characters
          sanitized.gsub!(ILLEGAL_CHARACTERS, '')
        end
   
        def remove_repeating_spaces
          sanitized.gsub!(/  +/, ' ')
          sanitized.gsub!(REPEATING_SPACES, ' ')
        end
        
        def strip_spaces
          sanitized.strip!
        end
        
        def clean_marriage_titles
          sanitized.gsub!(/Mr\.? \& Mrs\.?/i, 'Mr. and Mrs.')
        end
        
        def format_first_last_name
          sanitized.gsub!(/(.+),(.+)/, "\\2 \\1")
        end
        
        def remove_commas
          sanitized.gsub!(/,/, '')
        end
        
        def format_for_multiple_names
          sanitized.gsub!(/ +and +/i, " \& ")
        end
        
        def parse_first
          first_name = ''
          first_name_pattern = Regexp.new("^([#{NAME_PATTERN}]+)", true)
          if match = parse_name.match(first_name_pattern)
            first_name = match[1].strip
            first_name = first_name.titleize if proper?
          end
          first_name
        end
        
        def parse_middle
          middle_name = ''
          middle_name_pattern = Regexp.new("#{first}(.*?)#{last}")
          if match = parse_name.match(middle_name_pattern)
            middle_name = match[1].strip
            middle_name = middle_name.titleize if proper?
          end
          middle_name
        end
        
        def parse_last
          last_name = ''
          last_name_pattern = Regexp.new("#{LAST_NAME_PATTERN}$", true)
          if match = parse_name.match(last_name_pattern)
            last_name = match[1].strip
            last_name = last_name.titleize if proper?
          end
          last_name
        end
    
        def parse_title
          TITLES.each do |title_regexp|
            title_regexp = Regexp.new("^(#{title_regexp})(.+)", true)
            
            if title_match = sanitized.match(title_regexp)
              return title_match[1].strip
            end
          end
          
          return ''
        end
        
        def parse_suffix
          SUFFIXES.each do |suffix_regexp|
            suffix_regexp = Regexp.new("(.+) (#{suffix_regexp})$", true)
            
            if suffix_match = sanitized.match(suffix_regexp)
              suffix_str = suffix_match[2].strip
              suffix_str.capitalize! if proper?
              return suffix_str
            end
          end
          
          return ''
        end
        
        def build_name
          name_parts = []
          name_parts << title unless title.nil? || title == ''
          name_parts << first unless first.nil? || first == ''
          name_parts << middle unless middle.nil? || middle == ''
          name_parts << last unless last.nil? || last == ''
          name_parts << suffix unless suffix.nil? || suffix == ''
          name_parts.join(' ')
        end
    end
  end
end