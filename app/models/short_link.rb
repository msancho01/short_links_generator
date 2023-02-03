require 'open-uri'

class ShortLink < ApplicationRecord
  before_validation :generate_shortcode, on: [:create]

  validates :token, presence: true, allow_blank: false, uniqueness: { case_sensitive: true }
  validates :long_url, presence: true, format: { with:  /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix,
    message: "Invalid URL format"}
  validate :valid_url

  private
    def generate_shortcode
      shortcode = SecureRandom.urlsafe_base64(4)
      if ShortLink.find_by(token: shortcode).present?
        generate_shortcode
      else
        self.token = shortcode
      end
    end

    def valid_url
      begin
        URI.open(self.long_url)
      rescue
        errors.add(:long_url, "#{self.long_url} is not a valid URL")
      end
    end
end
