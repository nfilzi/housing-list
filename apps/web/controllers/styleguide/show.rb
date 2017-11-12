module Web::Controllers::Styleguide
  class Show
    include Web::Action
    include Web::Users::SkipAuthentication

    expose :base_font
    expose :header_font

    # Components
    # - Housing card
    expose :housing
    expose :trip

    def call(params)
      @base_font   = 'Roboto Mono'
      @header_font = 'Rubik'

      # Components
      # - Housing card
      @trip = OpenStruct.new(
        id: 1,
        travelers_count: 5,
        starting_on: Date.today
      )
      user = OpenStruct.new(
        first_name: 'Nicolas',
        last_name: 'Filzi',
        avatar_uuid: nil
      )
      @housing ||= OpenStruct.new(
        id: 42,
        user: user,
        trip: @trip,
        title: 'Ground floor with garden, calm.',
        description: 'Nice view over the lake, 55 sqm flat with garden.',
        url: '#',
        picture_url: nil,
        provider: 'airbnb',
        total_price: 2900,
        created_at: Time.parse('2017-05-30 17:55:00'),
        updated_at: Time.now,
        dismissed: false
      )
    end
  end
end
