module Medjool
  VERSION = 0.3

  require 'medjool/parser'
  require 'medjool/regexs'

  class << self

  end

  def self.parse(t, context = {})
    Medjool::Parser.new(context).parse(t)
  end
end