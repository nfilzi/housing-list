namespace :db do
  desc 'Seed the database with example data'
  task seed: :environment do
    puts 'Cleaning database...'
    UserRepository.new.clear
    TripRepository.new.clear
    puts '---'

    puts 'Creating users...'
    user_repo = UserRepository.new
    cecile  = user_repo.create(
      first_name: 'Cecile',
      last_name: 'Veneziani',
      email: 'cecile@housing-list.com',
      encrypted_password: BCrypt::Password.create('123456')
    )
    nicolas = user_repo.create(
      first_name: 'Nicolas',
      last_name: 'Filzi',
      email: 'nico@housing-list.com',
      encrypted_password: BCrypt::Password.create('123456')
    )
    puts '---'

    puts 'Creating trips...'
    trip_repo = TripRepository.new
    lake_geneva = trip_repo.create(
      destination: 'Lake Geneva',
      travelers_count: 5,
      starting_on: '2017-07-03',
      ending_on: '2017-07-07',
      invitation_token: 'QQJLXAMO'
    )
    puts '---'

    puts 'Creating organizers...'
    organizer_repo = TripOrganizerRepository.new
    organizer_repo.create(trip_id: lake_geneva.id, organizer_id: cecile.id)
    organizer_repo.create(trip_id: lake_geneva.id, organizer_id: nicolas.id)
    puts '---'

    puts 'Creating housings...'
    housing_repo = HousingRepository.new
    [{
      title: "Cozy studio in heart of Evian with garden view",
      description: "We invite you to discover our spacious and sunny studio of 38m2, recently renovated and decorated, with a great south facing garden view. It's cute and cozy, perfect for two, we're sure you'll love it!",
      url: "https://www.airbnb.com/rooms/16120958?check_in=2017-11-12&check_out=2017-11-18&guests=2&adults=2",
      provider: "airbnb",
      airbnb_id: 16120958,
      total_price: 841,
      picture_url: "https://a0.muscache.com/im/pictures/70d0b78e-f5ef-425d-82a5-aafa67f33599.jpg?aki_policy=xx_large",
      user_id: cecile.id,
      trip_id: lake_geneva.id
    },
    {
      title: "Two-bedroom Villa at Grand Geneva Resort & Spa",
      description: "Nestled in a beautiful and scenic Wisconsin setting, the new Grand Geneva Villas offer the perfect escape for guests wanting more space and added conveniences.",
      url: "https://www.airbnb.com/rooms/17526719?check_in=2017-11-12&check_out=2017-11-18&guests=2&adults=2",
      provider: "airbnb",
      airbnb_id: 17526719,
      total_price: 2218,
      picture_url: "https://a0.muscache.com/im/pictures/70d0b78e-f5ef-425d-82a5-aafa67f33594.jpg?aki_policy=xx_large",
      user_id: cecile.id,
      trip_id: lake_geneva.id
    },
    {
      title: "Duplex Le Yéti",
      description: "Situé à Thollon-les-Mémises et offrant une vue sur le lac Léman, le Duplex Le Yéti se trouve à seulement 50 mètres des pistes de ski les plus proches.",
      url: "https://www.booking.com/hotel/fr/duplex-le-ya-c-ti.fr.html",
      provider: "booking",
      total_price: 520,
      picture_url: "https://a0.muscache.com/im/pictures/70d0b78e-f5ef-425d-82a5-aafa67f33592.jpg?aki_policy=xx_large",
      user_id: nicolas.id,
      trip_id: lake_geneva.id
    }].each do |housing_attributes|
      housing_repo.create(housing_attributes)
    end
    puts '---'

    puts 'Finished!'
  end
end
