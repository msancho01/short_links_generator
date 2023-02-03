# hash of valid and real life web pages and the page title
valid_urls = {
  "https://www.google.com"=>"Google",
  "https://www.facebook.com"=>"Facebook - Inicia sesión o regístrate",
  "https://www.youtube.com"=>"YouTube",
  "https://www.wikipedia.org"=>"Wikipedia",
  "https://www.twitter.com"=>"Twitter",
  "https://www.instagram.com"=>"Instagram",
  "https://www.linkedin.com"=>"LinkedIn: Log In or Sign Up",
  "https://www.pinterest.com"=>"Pinterest",
  "https://www.apple.com"=>"Apple",
  "https://www.github.com"=>"GitHub: Let's build from here · GitHubPythonJavaScriptGo",
  "https://www.tiktok.com"=>"TikTok - Make Your Day",
  "https://www.whatsapp.com"=>"WhatsApp",
  "https://www.spotify.com"=>"Spotify - Web Player: Music for everyone",
  "https://www.reddit.com"=>"Reddit - Dive into anything",
  "https://www.dropbox.com"=>"Dropbox.com",
  "https://www.skype.com"=>" Skype | Stay connected with free video calls worldwide California Consumer Privacy Act (CCPA) Opt-Out IconCalifornia Consumer Privacy Act (CCPA) Opt-Out Icon",
  "https://www.zoom.us"=>"One platform to connect | Zoom",
  "https://www.lyft.com"=>"Lyft: A ride whenever you need oneLyft Logo",
  "https://www.airbnb.com"=>"Vacation Homes & Condo Rentals - Airbnb",
  "https://www.paypal.com"=>"Pagos en Línea en Costa Rica, Envíos de Fondos y Más - PayPal CR",
  "https://www.netflix.com"=>"Netflix Costa Rica - Watch TV Shows Online, Watch Movies Online",
}

6.times {
  valid_urls.each do |key, value|
    short_link = ShortLink.new(long_url: key, title: value, clicks_count: rand(1..5), token: SecureRandom.urlsafe_base64(4) )
    short_link.save(:validate => false)
  end
}