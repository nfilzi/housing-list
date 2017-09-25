module Web
  module Trips
    module Housings
      module Authorization

        private

        def load_trip_and_authorize
          @trip = TripRepository.new.find_with_organizers(params[:trip_id])
          halt 401 unless @trip && (user_organizer? || user_authorized?)
        end

        def user_organizer?
          @user_organizer ||= @trip.trip_organizers.any? { |organizer| organizer.organizer_id == current_user.id }
        end

        def user_authorized?
          token = session[:invitation_token].to_s
          return !token.empty? && token == @trip.invitation_token
        end
      end
    end
  end
end
