parsely
=======

A parser. It currently only parses person names. 

Based on Matthew Ericson's people gem: https://github.com/mericson/people which, in turn, is loosely based on 
the Lingua-EN-NameParser Perl module.

To set up development environment clone the repo and run `bundle` to get all of the dependencies.

Usage
-----
```
require "parsely"

name = "Captain Arthur Two Sheds Jackson Jr."

ppn = Parsely::PersonName.new(name)
ppn.run

ppn.first
=> "Arthur"
ppn.middle
=> "Two Sheds"
ppn.last
=> "Jackson"
ppn.title
=> "Captain"
ppn.suffix
=> "Jr."

ppn.to_hash
=> { :title => "Captain", :first => "Arthur", :middle => "Two Sheds", :last => "Jackson", :suffix => "Jr." }
```
