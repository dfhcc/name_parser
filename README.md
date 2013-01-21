NameParser
=========

Does what it says. Based on Matthew Ericson's people gem: https://github.com/mericson/people which, in turn, is loosely based on 
the Lingua-EN-NameParser Perl module.

To set up development environment clone the repo and run `bundle` to get all of the dependencies.

Usage
-----
```
require "name_parser"

include NameParser

name = "Captain Arthur Two Sheds Jackson Jr."

np = Parser.new(name)
np.run

np.first
=> "Arthur"
np.middle
=> "Two Sheds"
np.last
=> "Jackson"
np.title
=> "Captain"
np.suffix
=> "Jr."

np.to_hash
=> { :title => "Captain", :first => "Arthur", :middle => "Two Sheds", :last => "Jackson", :suffix => "Jr." }
```
