module Medjool
  DAYNAME_MATCHER = /(\s*Mon(day)?,?\s*|\s*Tue(s(day)?)?,?\s*|\s*Wed(nesday)?,?\s*|\s*Thur(s(day)?)?,?\s*|\s*Fri(day)?,?\s*|\s*Sat(urday)?,?\s*|\s*Sun(day)?,?\s*)/
  MONTH_MATCHER = /\s*(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|June?|July?|Aug(ust)?|Sept(ember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?),?\s*/
  YYYY_MM_DD_MATCHER = /(\s*[0-9]{4}-[0-9]{2}-[0-9]{2}\s*)/
  DM_DM_YYYY_MATCHER = /(\s*[0-9]{2}[-\/][0-9]{2}[-\/][0-9]{2,4}\s*)/
  ORDINAL_MATCHER = /(\s*([0-9]{1,2}(st|rd|nd|th)?),?\s*)/
  YEAR_MATCHER = /(\s*([0-9]{4}\s*|\s*'?[0-9]{2}),?\s*)/
  TEXT_DATE_MATCHER = /(#{DAYNAME_MATCHER}|#{ORDINAL_MATCHER}|#{YEAR_MATCHER}|#{MONTH_MATCHER})/
  DATE_MATCHER = /^(#{TEXT_DATE_MATCHER}+|#{DM_DM_YYYY_MATCHER}|#{YYYY_MM_DD_MATCHER})/
end