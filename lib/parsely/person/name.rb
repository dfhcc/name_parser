require 'parsely/person/name_constants'

module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :original
      attr_reader :sanitized
      attr_reader :couple
      alias :couple? :couple
      
      def initialize(name, opts={})
        @original  = name
        @sanitized = name.dup
        @couple    = opts[:couple] || false
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
          remove_illegal_characters
        end
        
        def remove_illegal_characters
          sanitized.gsub!(ILLEGAL_CHARACTERS, '')
        end
    
    end
  end
end