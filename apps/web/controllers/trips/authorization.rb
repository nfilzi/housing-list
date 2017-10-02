module Web
  module Trips
    module Authorization

      private

      def authorize
        if visitor? && no_token?
          store_current_location
          redirect_to routes.user_sign_in_path
        elsif @trip.nil?
          halt 404
        elsif user_not_organizer_nor_visitor_authorized?
          halt 404
        end
      end

      def no_token?
        params[:token].nil?
      end

      def user_not_organizer_nor_visitor_authorized?
        ((user_signed_in? && user_organizer?) || visitor_authorized?) == false
      end

      def user_organizer?
        TripOrganizerRepository.new.organizes_trip?(current_user.id, @trip.id)
      end

      def visitor?
        !user_signed_in?
      end

      def visitor_authorized?
        token = params[:token].to_s

        if !token.empty? && token == @trip.invitation_token
          session[:invitation_token] = params[:token]
          return true
        else
          return false
        end
      end
    end
  end
end
