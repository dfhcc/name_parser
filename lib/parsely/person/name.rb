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
      
      def first
        # thinking something like:
        # @first ||= parse_first_name
      end
      
      def middle
      end
      
      def last
      end
      
      def titles
      end
      
      def suffixes
      end
      
      private
      
        def sanitize
          remove_repeating_spaces
          remove_illegal_characters
        end
        
        def remove_illegal_characters
          sanitized.gsub!(ILLEGAL_CHARACTERS, '')
        end
   
        def remove_repeating_spaces
          sanitized.gsub!(REPEATING_SPACES, ' ')
        end
    
    end
  end
end