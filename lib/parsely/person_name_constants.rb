module Parsely
  module PersonNameConstants

    ILLEGAL_CHARACTERS = /[^A-Za-z0-9\-\'\.&\/ \,]/
    REPEATING_SPACES = /\s+/
    SUFFIXES = [
      'Jn?r\.?,? Esq\.?',
      'Sn?r\.?,? Esq\.?',
      'I{1,3},? Esq\.?',

      'Jn?r\.?,? M\.?D\.?',
      'Sn?r\.?,? M\.?D\.?',
      'I{1,3},? M\.?D\.?',

      'Sn?r\.?',         # Senior
      'Jn?r\.?',         # Junior

      'Esq(\.|uire)?',
      'Esquire.',
      'Attorney at Law.',
      'Attorney-at-Law.',

      'Ph\.?d\.?',
      'C\.?P\.?A\.?',

      'XI{1,3}',            # 11th, 12th, 13th
      'X',                  # 10th
      'IV',                 # 4th
      'VI{1,3}',            # 6th, 7th, 8th
      'V',                  # 5th
      'IX',                 # 9th
      'I{1,3}\.?',          # 1st, 2nd, 3rd
      'M\.?D\.?',           # M.D.
      'D.?M\.?D\.?'         # M.D.
    ]
  end
end
