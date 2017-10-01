class HousingPresenter
  include Hanami::Presenter

  def card_partial_name
    imported ? :housing_card : :housing_card_pending
  end

  def total_price_per_person(travelers_count)
    (total_price / travelers_count).to_i
  end
end
