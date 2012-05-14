module Parsely
  module PersonNameConstants

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

    TITLES = [ 'Mr\.? and Mrs\.? ',
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

    NAME_PATTERN = "([\\w\\-\\']+)[\.{1,}\\s|\\s]+"

    LAST_NAME_PATTERN = "\;?([\\w\\-\\']+|(Mc|Mac|Des|Dell[ae]|Del|De La|De Los|Da|Di|Du|La|Le|Lo|St\\.|Den|Von|Van|Von Der|Van De[nr])?\\s+([\\w]+))"
  end
end
