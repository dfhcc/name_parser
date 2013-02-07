module NameParser
  autoload :Version, 'name_parser/version'
  autoload :Patterns,'name_parser/patterns'
  autoload :Parser,  'name_parser/parser'

  def name_parser(name)
    Parser.new(name)
  end
end

class String
  include NameParser

  def parse_name
    return name_parser(self)
  end
end