module Web
  module Helpers
    module TextFormatter
      # Thanks Rails :)
      # See http://api.rubyonrails.org/classes/String.html#method-i-truncate
      def truncate(str, truncate_at, options = {})
        return str.dup unless str.length > truncate_at

        omission = options[:omission] || "..."
        length_with_room_for_omission = truncate_at - omission.length

        stop = if options[:separator]
            str.rindex(options[:separator], length_with_room_for_omission) || length_with_room_for_omission
          else
            length_with_room_for_omission
          end

        truncated_str = "#{str[0, stop]}#{omission}"

        if Hanami::Utils::Escape::SafeString === str
          raw truncated_str
        else
          truncated_str
        end
      end
    end
  end
end
