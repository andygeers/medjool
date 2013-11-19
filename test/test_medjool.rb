# encoding: utf-8

require 'helper'

class TestMedjool < TestCase

  def setup
    # Friday 23rd August 2013
    Timecop.freeze("2013-08-23".to_date)
  end

  def teardown
    Timecop.return
  end

  def test_parse_without_context
    @variations = ["Thu", "*Monday", "1st July", "2nd July 2010", "1 July 2009", "Monday 2nd July 2009", "Monday 2nd", "Monday 2", "Monday 2 July"]
    @variations.each do |t|
      assert_equal Date.parse(t), Medjool.parse(t), "Error parsing '#{t}'"
    end
  end

  def test_parse_with_context
    assert_equal "2013-09-02".to_date, Medjool.parse("Monday", { :now => 1.week.from_now })

    assert_equal "2014-03-30".to_date, Medjool.parse("30st", { :now => "2014-02-01" })

    assert_equal "2014-03-30".to_date, Medjool.parse("30st", { :now => "2014-02-01" })
  end

  def test_day_month_and_ordinal
    assert_equal "2013-10-01".to_date, Medjool.parse("Monday 1st October", {:now => "2013-08-23".to_date})
    assert_equal "2014-10-01".to_date, Medjool.parse("Monday 1st October", {:now => "2013-10-02".to_date})

    assert_equal "2013-10-01".to_date, Medjool.parse("1st October", {:now => "2013-08-23".to_date})
    assert_equal "2014-10-01".to_date, Medjool.parse("1st October", {:now => "2013-10-02".to_date})
  end

  def test_ordinal_only
    assert_equal "2013-09-01".to_date, Medjool.parse("1st", {:now => "2013-08-23".to_date})
    assert_equal "2013-08-01".to_date, Medjool.parse("1st", {:now => "2013-08-01".to_date})

    assert_equal "2013-10-31".to_date, Medjool.parse("31st", {:now => "2013-09-01".to_date})
    assert_equal "2013-09-30".to_date, Medjool.parse("30th", {:now => "2013-09-01".to_date})
  end

  def test_day_only
    assert_equal "2013-08-27".to_date, Medjool.parse("Tuesday", {:now => "2013-08-26".to_date})
    assert_equal "2013-08-27".to_date, Medjool.parse("Tuesday", {:now => "2013-08-27".to_date})
    assert_equal "2013-09-03".to_date, Medjool.parse("Tuesday", {:now => "2013-08-28".to_date})
  end

  def test_absolute_dates
    parser = Medjool::Parser.new
    assert_equal "2013-07-06".to_date, parser.parse("06/07/2013")
    assert_equal "2013-07-06".to_date, parser.parse("06/07/2013")
  end

  def test_is_date_range
    parser = Medjool::Parser.new
    assert parser.is_date_range?("October")
    assert parser.is_date_range?("12-15 Jan")
    assert parser.is_date_range?("12–15 Jan")
    assert !parser.is_date_range?("October 15")
    assert !parser.is_date_range?("09/12/2012")
    assert !parser.is_date_range?("I am working until next October")
  end

  def test_parse_date_range
    parser = Medjool::Parser.new
    date_range = parser.parse_date_range("October")
    assert_equal "2013-10-01".to_date, date_range.start_date
    assert_equal "2013-10-31".to_date, date_range.end_date
    date_range = parser.parse_date_range("12-15 Jan")
    assert_equal "2013-01-12".to_date, date_range.start_date
    assert_equal "2013-01-15".to_date, date_range.end_date
    assert parser.parse_date_range("October 15").nil?
  end

  def test_lone_numbers
    parser = Medjool::Parser.new
    assert_equal Date.parse("1st"), parser.parse("1")
    assert_equal Date.parse("2st"), parser.parse("2 ")
  end

  def test_invalid_dates
    assert_equal nil, Medjool.parse("Blah")
    assert_equal nil, Medjool.parse("31st February")
  end

  def test_crazy_unicode_junk
    parser = Medjool::Parser.new
    assert parser.parse("￼3")
  end
end