require 'parsely/person/name_constants'

module Parsely
  module Person
    include NameConstants
    
    class Name
      attr_reader :original
      attr_reader :sanitized
      attr_reader :couple
      alias :couple? :couple
      
      def initialize(name, opts={})
        @original = name
        @couple   = opts[:couple] || false
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
          @sanitized = @original.dup
          #clean here
        end
    
    end
  end
end