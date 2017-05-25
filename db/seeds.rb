[{
  title: "Cozy studio in heart of Evian with garden view",
  description: "We invite you to discover our spacious and sunny studio of 38m2, recently renovated and decorated, with a great south facing garden view. It's cute and cozy, perfect for two, we're sure you'll love it!",
  url: "https://www.airbnb.com/rooms/16120958",
  provider: "airbnb",
  total_price: "841",
  user_id: 1,
  trip_id: 1
},
{
  title: "Two-bedroom Villa at Grand Geneva Resort & Spa",
  description: "Nestled in a beautiful and scenic Wisconsin setting, the new Grand Geneva Villas offer the perfect escape for guests wanting more space and added conveniences.",
  url: "https://www.airbnb.com/rooms/17526719",
  provider: "airbnb",
  total_price: "2218",
  user_id: 1,
  trip_id: 1
},
{
  title: "Duplex Le Yéti",
  description: "Situé à Thollon-les-Mémises et offrant une vue sur le lac Léman, le Duplex Le Yéti se trouve à seulement 50 mètres des pistes de ski les plus proches.",
  url: "https://www.booking.com/hotel/fr/duplex-le-ya-c-ti.fr.html",
  provider: "booking",
  total_price: "520",
  user_id: 1,
  trip_id: 1
}].each do |housing_attributes|
  repo.create(housing_attributes)
end
