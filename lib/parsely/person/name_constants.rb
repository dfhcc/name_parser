module Parsely
  module Person
    module NameConstants
      NAME_PATTERN           = "A-Za-z0-9\\-\\'"
      LAST_NAME_PATTERN      = "((;.+)|(((Mc|Mac|Des|Dell[ae]|Del|De La|De Los|Da|Di|Du|La|Le|Lo|St\.|Den|Von|Van|Von Der|Van De[nr]) )?([#{NAME_PATTERN}]+)))"
      MULT_LAST_NAME_PATTERN = "((;.+)|(((Mc|Mac|Des|Dell[ae]|Del|De La|De Los|Da|Di|Du|La|Le|Lo|St\.|Den|Von|Van|Von Der|Van De[nr]) )?([#{NAME_PATTERN} ]+)))"
      
      ILLEGAL_CHARACTERS     = /[^A-Za-z0-9\-\'\.&\/ \,]/
      REPEATING_SPACES       = /\s+/
      
      NAME_PATTERNS = [
        "^([A-Za-z])\.? ([A-Za-z])\.? (#{LAST_NAME_PATTERN})$",                       # A LAST_NAME
        "^([A-Za-z])\.? ([A-Za-z])\.? (#{LAST_NAME_PATTERN})$",                       # A B LAST_NAME
        "^([A-Za-z])\.([A-Za-z])\. (#{LAST_NAME_PATTERN})$",                          # A.B. LAST_NAME
        "^([A-Za-z])\.? ([A-Za-z])\.? ([A-Za-z])\.? (#{LAST_NAME_PATTERN})$",         # A B C LAST_NAME
        "^([A-Za-z])\.? ([#{NAME_PATTERN}]+) (#{LAST_NAME_PATTERN})$",                # A MIDDLE_NAME LAST_NAME
        "^([#{NAME_PATTERN}]+) ([A-Za-z])\.? (#{LAST_NAME_PATTERN})$",                # FIRST_NAME M LAST_NAME
        "^([#{NAME_PATTERN}]+) ([A-Za-z])\.? ([A-Za-z])\.? (#{LAST_NAME_PATTERN})$",  # FIRST_NAME A B LAST_NAME
        "^([#{NAME_PATTERN}]+) ([A-Za-z]\.[A-Za-z]\.) (#{LAST_NAME_PATTERN})$",       # FIRST_NAME A. B. LAST_NAME
        "^([#{NAME_PATTERN}]+) (#{LAST_NAME_PATTERN})$",                              # FIRST_NAME LAST_NAME
        "^([#{NAME_PATTERN}]+) ([#{NAME_PATTERN}]+) (#{LAST_NAME_PATTERN})$",         # FIRST_NAME MIDDLE_NAME LAST_NAME
        "^([#{NAME_PATTERN}]+) ([A-Za-z])\.? (#{MULT_LAST_NAME_PATTERN})$"            # FIRST_NAME M. LAST_NAME1 LAST_NAME2
      ]
      
      TITLES = [
        'Mr\.? and Mrs\.? ',
        'Mrs\.? ',
        'M/s\.? ',
        'Ms\.? ',
        'Miss\.? ',
        'Mme\.? ',
        'Mr\.? ',
        'Messrs ',
        'Mister ',
        'Mast(\.|er)? ',
        'Ms?gr\.? ',
        'Sir ',
        'Lord ',
        'Lady ',
        'Madam(e)? ',
        'Dame ',
  
        # Medical
        'Dr\.? ',
        'Doctor ',
        'Sister ',
        'Matron ',
  
        # Legal
        'Judge ',
        'Justice ',
  
        # Police
        'Det\.? ',
        'Insp\.? ',
  
        # Military
        'Brig(adier)? ',
        'Capt(\.|ain)? ',
        'Commander ',
        'Commodore ',
        'Cdr\.? ',
        'Colonel ',
        'Gen(\.|eral)? ',
        'Field Marshall ',
        'Fl\.? Off\.? ',
        'Flight Officer ',
        'Flt Lt ',
        'Flight Lieutenant ',
        'Pte\. ',
        'Private ',
        'Sgt\.? ',
        'Sargent ',
        'Air Commander ',
        'Air Commodore ',
        'Air Marshall ',
        'Lieutenant Colonel ',
        'Lt\.? Col\.? ',
        'Lt\.? Gen\.? ',
        'Lt\.? Cdr\.? ',
        'Lieutenant ',
        '(Lt|Leut|Lieut)\.? ',
        'Major General ',
        'Maj\.? Gen\.?',
        'Major ',
        'Maj\.? ',
  
        # Religious
        'Rabbi ',
        'Brother ',
        'Father ',
        'Chaplain ',
        'Pastor ',
        'Bishop ',
        'Mother Superior ',
        'Mother ',
        'Most Rever[e|a]nd ',
        'Very Rever[e|a]nd ',
        'Mt\.? Revd\.? ',
        'V\.? Revd?\.? ',
        'Rever[e|a]nd ',
        'Revd?\.? ',
  
        # Other
        'Prof(\.|essor)? ',
        'Ald(\.|erman)? '
      ]
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
end