require 'json'
require 'open-uri'
require 'uri'

class RandomPicture
  LANDSCAPE_ORIENTATIONS = [5, 6, 7, 8]

  MIN_WIDTH  = 2800
  MIN_HEIGHT = 1000

  private
  attr_reader :destination, :license

  public
  def self.find(destination)
    new(destination).find
  end

  def initialize(destination)
    @destination = destination
    @license     = 'CC-SA-1.0'
  end

  def find
    response = call_api
    image    = pick_best_image(response)

    return image['url']
  end

  private

  def api_url
    base_url = 'https://commons.wikimedia.org/w/api.php'
    params   = {
      format:    'json',
      action:    'query',
      titles:    destination,
      list:      'categorymembers',
      cmtype:    'file',
      cmtitle:   "Category:#{license}",
      generator: 'images',
      prop:      'imageinfo',
      iiprop:    'url|size|dimensions|mime|metadata',
      gimlimit:  '5',
      redirects: '1'
    }

    encoded_params = URI.encode_www_form(params)

    return "#{base_url}?#{encoded_params}"
  end

  def call_api
    response = open(api_url).read
    return JSON.parse(response)
  end

  def pick_best_image(response)
    images = response['query'].fetch('pages', {}).values

    image = images.find do |image|
      image_details = image['imageinfo'].first
      orientation   = image_details['metadata'].find { |metadata| metadata['name'] == 'Orientation' }
      width         = image_details['width']
      height        = image_details['height']

      # RULES:
      # - NO orientation specified
      # - OR landscape orientation
      # - OR min width and min height respected
      orientation.nil? ||
        LANDSCAPE_ORIENTATIONS.include?(orientation['value']) ||
        (width >= MIN_WIDTH && height >= MIN_HEIGHT)
    end

    return {} unless image
    image['imageinfo'].first
  end
end
