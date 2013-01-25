module NameParser
  autoload :Version, 'name_parser/version'
  autoload :Patterns,'name_parser/patterns'
  autoload :Parser,  'name_parser/parser'

  def parse_name(name)
    parser = Parser.new(name)
    parser.run
    parser
  end
end
