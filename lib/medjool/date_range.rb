require 'active_support'
require 'active_support/core_ext'

class Medjool::DateRange

  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end
end
