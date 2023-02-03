require 'rails_helper'

RSpec.describe ShortLink, type: :model do
  describe "validations" do
    subject { FactoryBot.create(:short_link) }

    it { should validate_presence_of(:long_url) }
    it { should validate_presence_of(:token) }
    # it { should validate_uniqueness_of(:token) }

    it "should validate format of Long Url" do
      valid_urls = [
        "https://www.example.com",
        "http://www.example.com",
        "ftp://www.example.com"
      ]

      valid_urls.each do |valid_url|
        short_link = ShortLink.new(long_url: valid_url)
        expect(short_link).to be_valid
      end

      invalid_urls = [
        "www.example.com",
        "example.com",
        "https://www"
      ]

      invalid_urls.each do |invalid_url|
        short_link = Link.new(long_url: invalid_url)
        expect(short_link).to_not be_valid
      end
    end
  end

  describe "#generates_short_link" do
    it "generates a unique token before saving" do
      short_link = ShortLink.new(original_url: "https://example.com")
      short_link.save
      expect(short_link.token).to be_present
    end
  end
end
