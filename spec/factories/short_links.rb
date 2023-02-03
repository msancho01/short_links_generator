FactoryBot.define do
  factory :short_link do
    long_url { "https://www.example.com" }
    token { SecureRandom.urlsafe_base64(4) }
    clicks_count { 4 }
  end
end
