module Web
  # Public: Expsos the current_action
  #
  # Examples
  #
  #   action
  #   # => #<Web::Controllers::Trips::Show>
  #   current_action
  #   # => "tips-show"
  module CurrentAction
    def self.included(action)
      action.class_eval do
        expose :current_action

        define_method :current_action do
          action.to_s.downcase.gsub('::', '-').sub('web-controllers-', '')
        end
      end
    end
  end
end
