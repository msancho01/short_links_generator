require 'open-uri';
require 'nokogiri';

class UpdateShortLinkTitle
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(id)
    short_link = ShortLink.find(id)
    if short_link
      title = Nokogiri::HTML(URI.open(short_link.long_url)).css('title').text rescue "Unknown"
      short_link.update(title: title)
    end
  end
end