class HousingPresenter
  include Hanami::Presenter

  def card_partial_name
    imported ? :housing_card : :housing_card_pending
  end

  def picture
    picture_url || 'housing-picture-placeholder.jpg'
  end

  def proposer_avatar
    UserPresenter.new(user).avatar_url
  end

  def total_price_per_person(travelers_count)
    return '---' unless total_price
    (total_price / travelers_count).to_i
  end
end
