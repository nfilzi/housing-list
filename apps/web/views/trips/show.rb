module Web::Views::Trips
  class Show
    include Web::View

    def days_before_trip
      (trip.starting_on - Date.today).to_i
    end

    def format_trip_date(date)
      format_date(date, format: '%b %e', ordinal_indicators: true)
    end

    def housings_count
      housing_stats.housings_count
    end

    def housing_total_price_per_person(housing)
      (housing.total_price / trip.travelers_count).to_i
    end

    def trip_not_started?
      Date.today < trip.starting_on
    end

    def total_price_avg
      housing_stats.total_price_avg
    end

    def total_price_min
      housing_stats.total_price_min
    end

    def total_price_max
      housing_stats.total_price_max
    end

    # ##################################################
    # GENERIC
    # ##################################################

    def format_date(date, format: '%d/%m/%Y', ordinal_indicators: false)
      if ordinal_indicators
        indicator = date_ordinal_indicator(date)
        format    = format.gsub('%e', "%e#{indicator}")
      end

      date.strftime(format)
    end

    def date_ordinal_indicator(date)
      case date.day
      when 1     then 'st'
      when 2, 22 then 'nd'
      when 3, 33 then 'rd'
      else
        'th'
      end
    end

    # Thanks Rails :)
    # http://api.rubyonrails.org/classes/String.html#method-i-truncate
    def truncate(str, truncate_at, options = {})
      return str.dup unless str.length > truncate_at

      omission = options[:omission] || "..."
      length_with_room_for_omission = truncate_at - omission.length

      stop = if options[:separator]
          str.rindex(options[:separator], length_with_room_for_omission) || length_with_room_for_omission
        else
          length_with_room_for_omission
        end

      "#{str[0, stop]}#{omission}"
    end
  end
end
