# NameParser [![Build Status](https://secure.travis-ci.org/dfhcc/name_parser.png)](http://travis-ci.org/dfhcc/name_parser)


Does what it says. Based on Matthew Ericson's people gem: https://github.com/mericson/people which, in turn, is loosely based on 
the Lingua-EN-NameParser Perl module.

To set up development environment clone the repo and run `bundle` to get all of the dependencies.

## Usage

```ruby
require "name_parser"

include NameParser

name = "Captain Arthur Two Sheds Jackson Jr."

parser = Parser.new(name)

parser.first  # => "Arthur"
parser.middle # => "Two Sheds"
parser.last   # => "Jackson"
parser.title  # => "Captain"
parser.suffix # => "Jr."
```

or using the mixin

```ruby
require "name_parser"

include NameParser

name = "Captain Arthur Two Sheds Jackson Jr."

parser = name_parser(name) # => NameParser::Parser

parser.first # => "Arthur"
# ...
```
