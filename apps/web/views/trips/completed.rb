require_relative 'index'

module Web::Views::Trips
  class Completed < Web::Views::Trips::Index
    template 'trips/index'
  end
end
