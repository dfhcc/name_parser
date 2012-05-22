require 'titleize'

module Parsely
  autoload :Version,        'parsely/version'
  
  module Person
    autoload :Name,           'parsely/person/name'
    autoload :NameConstants,  'parsely/person/name_constants'
  end
end
