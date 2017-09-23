module Web
  module Helpers
    module DateFormatter
      # Public: Format given date.
      #
      # date  - The Date to be formatted.
      #
      # Options
      #
      #   format            - The String that is used as format (default: '%d/%m/%Y')
      #   ordinal_indicator - Whether the day has ordinal indicator
      #                       (st, nd, rd or th) or not (default: false)
      #
      # Examples
      #
      #   date = Date.today
      #   # => #<Date: 2017-05-28 ((2457902j,0s,0n),+0s,2299161j)>
      #   format_date(date)
      #   # => '28/05/2017'
      #   format_date(date, format: '%b %e')
      #   # => 'Jun 28'
      #   format_date(date, format: '%b %e', ordinal_indicator: true)
      #   # => 'Jun 28th'
      #
      # Returns the formatted String.
      def format_date(date, format: '%d/%m/%Y', ordinal_indicator: false)
        if ordinal_indicator
          indicator = date_ordinal_indicator(date)
          format    = format.gsub('%e', "%e#{indicator}")
        end

        date.strftime(format)
      end

      private

      def date_ordinal_indicator(date)
        case date.day
        when 1, 21, 31 then 'st'
        when 2, 22     then 'nd'
        when 3, 23     then 'rd'
        else
          'th'
        end
      end
    end
  end
end
