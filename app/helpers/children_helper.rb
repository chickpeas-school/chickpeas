module ChildrenHelper
  def weekdays
    Date::DAYNAMES - ["Sunday", "Saturday"]
  end

  def weekday_objects
    weekdays.map do |day|
      HashWithIndifferentAccess.new(symbol: day_symbol(day), display: day)
    end
  end

  def day_symbol(day)
    "days_#{day.downcase}".to_sym
  end

  def day_symbols
    weekdays.map { |day| day_symbol(day) }
  end

  def day_checkboxes_to_string(day_params)
    day_params.each_with_object([]) do |(key,val), acc|
      if val.eql?("0")
        next
      end

      if key.eql?("days_monday")
        acc.append("M")
      elsif key.eql?("days_tuesday")
        acc.append("T")
      elsif key.eql?("days_wednesday")
        acc.append("W")
      elsif key.eql?("days_thursday")
        acc.append("Th")
      elsif key.eql?("days_friday")
        acc.append("F")
      end

      next
    end.join(",")
  end
end
