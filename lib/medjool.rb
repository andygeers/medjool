module Medjool
  VERSION = '0.5.4'

  require 'medjool/parser'
  require 'medjool/date_range'
  require 'medjool/regexs'

  class << self

  end

  def self.parse(t, context = {})
    Medjool::Parser.new(context).parse(t)
  end
end
