require_relative '../presenters/user_presenter'

module Web::Views
  module PresentCurrentUser
    def current_user
      return unless locals[:current_user]
      UserPresenter.new(locals[:current_user])
    end
  end
end
