require 'rubygems'
require 'rspec'
require 'debugger' if RUBY_VERSION < "2.0" && RUBY_VERSION >= "1.9"

$:.push File.expand_path("../lib", __FILE__)
require 'name_parser'