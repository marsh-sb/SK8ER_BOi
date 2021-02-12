class Park < ApplicationRecord
  belongs_to :user
  attachment :park_image
  # geocoded_by :address
  after_validation :geocode

  with_options presence: true do
    validates :parkname, length: { maximum: 25 }
    validates :parkbody
    validates :address
    validates :latitude
    validates :longitude
  end


  private
  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=#{ENV['API_KEY']}")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
