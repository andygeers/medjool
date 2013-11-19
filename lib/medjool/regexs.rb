# encoding: utf-8

module Medjool
  DAYNAME_MATCHER = /(\s*Mon(day)?,?\s*|\s*Tue(s(day)?)?,?\s*|\s*Wed(nesday)?,?\s*|\s*Thu(r(s(day)?)?)?,?\s*|\s*Fri(day)?,?\s*|\s*Sat(urday)?,?\s*|\s*Sun(day)?,?\s*)/
  MONTH_NAME_MATCHER = /(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|June?|July?|Aug(ust)?|Sept(ember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)/
  MONTH_MATCHER = /\s*#{MONTH_NAME_MATCHER},?\s*/
  YYYY_MM_DD_MATCHER = /(\s*[0-9]{4}-[0-9]{2}-[0-9]{2}\s*)/
  DM_DM_YYYY_MATCHER = /(\s*[0-9]{2}[-\/][0-9]{2}[-\/][0-9]{2,4}\s*)/
  ORDINAL_POSTFIX = /(st|rd|nd|th)/
  ORDINAL_MATCHER = /(\s*([0-9]{1,2}#{ORDINAL_POSTFIX}?),?\s*)/
  END_OF_MONTH_MATCHER = /^\s*(29|30|31)#{ORDINAL_POSTFIX}?\s*$/
  YEAR_MATCHER = /(\s*([0-9]{4}\s*|\s*'?[0-9]{2}),?\s*)/
  TEXT_DATE_MATCHER = /(#{DAYNAME_MATCHER}|#{ORDINAL_MATCHER}|#{YEAR_MATCHER}|#{MONTH_MATCHER})/
  DATE_MATCHER = /^[^a-zA-Z0-9]*(#{TEXT_DATE_MATCHER}+|#{DM_DM_YYYY_MATCHER}|#{YYYY_MM_DD_MATCHER})/

  DATE_RANGE_MATCHER = /^((([0-9]+) ?[-–] ?([0-9]+) #{MONTH_NAME_MATCHER})|#{MONTH_NAME_MATCHER})$/
end