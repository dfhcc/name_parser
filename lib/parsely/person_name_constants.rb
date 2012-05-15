module Parsely
  module PersonNameConstants

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

    SUFFIX_PATTERN = 'Jn?r\.?,? Esq\.?|Sn?r\.?,? Esq\.?|I{1,3},? Esq\.?|Jn?r\.?,? M\.?D\.?|Sn?r\.?,? M\.?D\.?|I{1,3},? M\.?D\.?|Sn?r\.?|Jn?r\.?|Esq(\.|uire)?|Esquire.|Attorney at Law.|Attorney-at-Law.|Ph\.?d\.?|C\.?P\.?A\.?|XI{1,3}|X|IV|VI{1,3}|V|IX|I{1,3}\.?|M\.?D\.?|D.?M\.?D\.?'
    NAME_PATTERN = "([\\w\\-\\']+)[\.{1,}\\s|\\s]+"
    LAST_NAME_PATTERN = "\;?([\\w\\-\\']+|(Mc|Mac|Des|Dell[ae]|Del|De La|De Los|Da|Di|Du|La|Le|Lo|St\\.|Den|Von|Van|Von Der|Van De[nr])?\\s+([\\w]+))"
  end
end
