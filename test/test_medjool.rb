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
    assert_equal Date.parse("Monday") + 1.week, Medjool.parse("Monday", { :now => 1.week.from_now })

    assert_equal "2014-03-31".to_date, Medjool.parse("31st", { :now => "2014-02-01" })

    assert_equal "2014-03-31".to_date, Medjool.parse("31st", { :now => "2014-02-01" })
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
end