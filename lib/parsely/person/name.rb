require 'parsely/person/name_constants'

module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :name
      attr_reader :original
      attr_reader :couple
      attr_reader :proper
      
      alias :couple? :couple
      alias :proper? :proper
      
      def initialize(name, opts={})
        @original  = name
        @name      = name.dup
        
        @couple    = opts[:couple].nil? ? false : opts[:couple]
        @proper    = opts[:proper].nil? ? true  : opts[:proper]
      end
      
      def sanitized
        @sanitized ||= sanitize
      end
      
      def full_name
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
          
          name
        end
        
        def remove_illegal_characters
          name.gsub!(ILLEGAL_CHARACTERS, '')
        end
    
    end
  end
end