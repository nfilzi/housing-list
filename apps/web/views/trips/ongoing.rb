require_relative 'index'

module Web::Views::Trips
  class Ongoing < Web::Views::Trips::Index
    template 'trips/index'
  end
end
