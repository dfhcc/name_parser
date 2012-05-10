require 'parsely/person/name_constants'

module Parsely
  module Person
    class Name
      include NameConstants
    
      attr_reader :original
      attr_reader :sanitized
      attr_reader :couple
      attr_reader :proper
      
      alias :couple? :couple
      alias :proper? :proper
      
      def initialize(name, opts={})
        @original  = name
        @couple    = opts[:couple] || false
        @proper    = opts[:proper] || true
      end
      
      def sanitized
        @sanitized ||= sanitize
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
          name = @original.dup
          remove_illegal_characters(name)
          
          name
        end
        
        def remove_illegal_characters(name)
          name.gsub!(ILLEGAL_CHARACTERS, '')
        end
    
    end
  end
end