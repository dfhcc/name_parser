require 'parsely/person/name_constants'

module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :sanitized
      attr_reader :original
      attr_reader :couple
      attr_reader :proper
      
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
      end
      alias :to_s :name
      
      def first
        # thinking something like:
        # @first ||= parse_first_name
      end
      
      def middle
      end
      
      def last
      end
      
      def title
        @title ||= parse_title
      end
      
      def suffix
        @suffix ||= parse_suffix
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
          sanitized.gsub!(/(.+),(.+)/, "\\2 ;\\1")
        end
        
        def remove_commas
          sanitized.gsub!(/,/, '')
        end
        
        def format_for_multiple_names
          sanitized.gsub!(/ +and +/i, " \& ")
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
              return suffix_match[2].strip
            end
          end
          
          return ''
        end
    end
  end
end