require 'active_support/core_ext'

class Medjool::Parser

  attr_reader :context

  def initialize(context = {})
    @context = context
  end

  def is_date_range?(text)
    Medjool::DATE_RANGE_MATCHER.match(text.strip).present?
  end

  def parse_date_range(text)
    if bits = Medjool::DATE_RANGE_MATCHER.match(text.strip)
      if bits[15]
        # October
        if month_start = self.parse(text.strip, update_now = false)
          month_end = month_start.end_of_month
          return Medjool::DateRange.new(month_start, month_end)
        end
      elsif bits[2]
        # 12-15 Oct
        # Start is 12 Oct
        range_start = self.parse("#{bits[3]} #{bits[5]}", update_now = false)
        # End is 15 Oct
        range_end = self.parse("#{bits[4]} #{bits[5]}", update_now = false)
        return Medjool::DateRange.new(range_start, range_end)
      end
    end
  end

  def parse(text, update_now = true)
    if Medjool::DATE_MATCHER.match(text)
      if /^[0-9]$/.match(text.strip)
        # Handle lone integers
        text = "#{text.strip}st"
      end

      begin
        base_date = Date.parse(text)
      rescue ArgumentError => e
        # If Date.parse is used on the string "31st" during
        # a month with only 30 days, it will explode
        if Medjool::END_OF_MONTH_MATCHER.match(text)
          # This is a little bit hacky, but switch to a date that will definitely work
          base_date = Date.parse("#{text} January")
        else
          return nil
        end
      end

      unless @context[:now]
        # In the absence of context, always fall back on the default guess
        guess_date = base_date
      else
        # Determine the ambiguity level for this data
        ambiguity = determine_ambiguity(text)

        now = @context[:now].to_date

        case ambiguity
          when :none
            return base_date

          when :weekly
            # Pick the nearest week that meets the context
            guess_date = now + (base_date.wday - now.wday).days - 1.week

            while guess_date < now
              guess_date += 1.week
            end
          when :monthly
            # Pick the nearest month where the provided day of the month meets the context
            y = now.year
            m = now.month - 1
            guess_date = nil

            while guess_date.nil? || guess_date < now
              m += 1
              if m > 12
                m = 1
                y += 1
              end
              begin
                guess_date = Date.new(y, m, base_date.day)
              rescue ArgumentError
                # This might happen e.g. 31st Feb,
                # so just carry on to the next month
                next
              end
            end

          when :yearly
            # Skip ahead a year at a time unless we meet the context
            guess_date = Date.new(now.year, base_date.month, base_date.day)
            while guess_date < now
              guess_date += 1.year
            end

        end
      end

      @context[:now] = guess_date if update_now
      return guess_date
    else
      return nil
    end
  end

  protected

  def determine_ambiguity(text)
    if /#{Medjool::DM_DM_YYYY_MATCHER}|#{Medjool::YYYY_MM_DD_MATCHER}/.match(text)
      # Plain as day
      return :none
    end

    # Work out how much detail we have
    data_present = {
      :day_name => Medjool::DAYNAME_MATCHER.match(text),
      :month => Medjool::MONTH_MATCHER.match(text),
      :ordinal => Medjool::ORDINAL_MATCHER.match(text)
    }

    if data_present[:month] && data_present[:ordinal]
      # 1st December
      return :yearly
    elsif data_present[:ordinal]
      # Monday 1 or just 1st
      return :monthly
    elsif data_present[:day_name] && !data_present[:month]
      # Tuesday
      return :weekly
    else
      # Unknown
      return nil
    end
  end
end