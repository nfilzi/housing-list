namespace :db do
  desc 'Seed the database with example data'
  task seed: :environment do
    puts 'Cleaning database...'
    UserRepository.new.clear
    TripRepository.new.clear

    puts 'Creating users...'
    user_repo = UserRepository.new
    cecile  = user_repo.create(first_name: 'Cecile', last_name: 'Veneziani')
    nicolas = user_repo.create(first_name: 'Nicolas', last_name: 'Filzi')

    puts 'Creating trips...'
    trip_repo = TripRepository.new
    lake_geneva = trip_repo.create(destination: 'Lake Geneva', travelers_count: 5, starting_on: '2017-07-03', ending_on: '2017-07-07')

    puts 'Creating organizers...'
    organizer_repo = TripOrganizerRepository.new
    organizer_repo.create(trip_id: lake_geneva.id, organizer_id: cecile.id)
    organizer_repo.create(trip_id: lake_geneva.id, organizer_id: nicolas.id)

    puts 'Creating housings...'
    housing_repo = HousingRepository.new
    [{
      title: "Cozy studio in heart of Evian with garden view",
      description: "We invite you to discover our spacious and sunny studio of 38m2, recently renovated and decorated, with a great south facing garden view. It's cute and cozy, perfect for two, we're sure you'll love it!",
      url: "https://www.airbnb.com/rooms/16120958",
      provider: "airbnb",
      total_price: "841",
      user_id: cecile.id,
      trip_id: lake_geneva.id
    },
    {
      title: "Two-bedroom Villa at Grand Geneva Resort & Spa",
      description: "Nestled in a beautiful and scenic Wisconsin setting, the new Grand Geneva Villas offer the perfect escape for guests wanting more space and added conveniences.",
      url: "https://www.airbnb.com/rooms/17526719",
      provider: "airbnb",
      total_price: "2218",
      user_id: cecile.id,
      trip_id: lake_geneva.id
    },
    {
      title: "Duplex Le Yéti",
      description: "Situé à Thollon-les-Mémises et offrant une vue sur le lac Léman, le Duplex Le Yéti se trouve à seulement 50 mètres des pistes de ski les plus proches.",
      url: "https://www.booking.com/hotel/fr/duplex-le-ya-c-ti.fr.html",
      provider: "booking",
      total_price: "520",
      user_id: nicolas.id,
      trip_id: lake_geneva.id
    }].each do |housing_attributes|
      housing_repo.create(housing_attributes)
    end

    puts 'Finished!'
  end
end
