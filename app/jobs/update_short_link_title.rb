require 'open-uri';
require 'nokogiri';

class UpdateShortLinkTitle
  include Sidekiq::Job

  def perform(id)
    short_link = ShortLink.find(id)
    if short_link
      short_link.update(title: Nokogiri::HTML(URI.open(short_link.long_url)).css('title').text)
    end
  end
end