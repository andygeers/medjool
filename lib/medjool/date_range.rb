require 'active_support'
require 'active_support/core_ext'

class Medjool::DateRange

  attr_accessor :start_date, :end_date, :prefix

  def initialize(start_date, end_date, prefix = nil)
    @start_date = start_date
    @end_date = end_date
    @prefix = prefix
  end
end
