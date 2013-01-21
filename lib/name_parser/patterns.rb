module NameParser
  module Patterns 

    NAME_PATTERN = "([\\w\\-\\']+)[\.{1,}\\s|\\s]+"
    LAST_NAME_PATTERN = "\;?([\\w\\-\\']+|(Mc|Mac|Des|Dell[ae]|Del|De La|De Los|Da|Di|Du|La|Le\
    |Lo|St\\.|Den|Von|Van|Von Der|Van De[nr])?\\s+([\\w]+))"

    SUFFIX_PATTERN = "Jn?r\.?,? Esq\.?|Sn?r\.?,? Esq\.?|I{1,3},? Esq\.?|Jn?r\.?,? M\.?D\.?|Sn?r\.?,? M\.?D\.?|\
    I{1,3},? M\.?D\.?|Sn?r\.?|Jn?r\.?|Esq(\.|uire)?|Esquire.|Attorney at Law.|Attorney-at-Law.|Ph\.?d\.?|C\.?P\.?A\.?|\
    XI{1,3}|X|IV|VI{1,3}|V|IX|I{1,3}\.?|M\.?D\.?|D.?M\.?D\.?"
 
    STANDARD = "M(ister|aster|issus|iss|r\\.?|rs\\.?|s\\.?|mme\\.?|essr\\.?)"
    ROYALTY = "Sir|Lord|Lady|Madam(e)?|Dame|Duke|Duchess|King|Queen|Prince|Princess"
    MEDICINE = "D(r\\.?|octor)|Sister|Matron"
    LEGAL = "Judge|Justice|Att(\\.|orney) Gen(\\.|eral)"
    POLICE = "Det(\\.|ective) Insp(\\.|ector)|Det(\\.|ective)|Insp(\\.|ector)|Chief|Constable|Officer"
    MILITARY = "Brig(adier)?|Capt(\\.?|ain)|C(dr\\.?|ommander|ommodore)|Col(\\.?|onel)|\
    Gen(\\.?|eral)|Field Marshall|Fl(\\.?|ight) Off(\\.?|icer)|Fl(t\\.?|ight) L(t\\.?|ieutenant)|\
    P(te\\.?|rivate)|S(gt\\.?|argent)|Air (Commander|Commodore| Marshall)|L(t\\.?|ieutenant) (Col(\\.?|onel)|\
    Gen(\\.?|eral)|C(Cdr\\.?|ommander))|L(t\\.?|eut\\.?|ieutenant|eutenant)|Maj(\\.?|or) Gen(\\.?|eral)|Maj(\\.?|or)"
    RELIGIOUS = "Rabbi|Brother|Father|Chaplain|Pastor|(Archb|B)ishop|Cardinal|Pope|\
    Mother( Superior)?|(Most|Mt\\.|Very|V.) Re(v\\.?|vd\\.?|ver[e|a]nd)|Re(v\\.?|vd\\.?|er[e|a]nd)"
    POLITICIAN = "Mayor|Sen(\\.|ator)?|Rep(\\.|resentative)?|Ald(\\.|erman)?|Pres(\\.|ident)?|\
    Ambassador|Assembly(woman|man)|Chair(woman|man)|Commissioner|Congress(woman|man)|Council(wo)man|\
    Counselor|Delegate|(Lieutentant )Governor|Postmaster( General)"
    EDUCATOR = "Dean|President|Ass(\\.|oc\\.|ociate|t\\.|istant) Prof(\\.|essor)|Prof(\\.|essor)"
    TITLE_PATTERN = [ STANDARD, ROYALTY, MEDICINE, LEGAL, POLICE, MILITARY, RELIGIOUS, POLITICIAN, EDUCATOR ].join("|")
 end
end
