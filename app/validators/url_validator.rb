require 'open-uri'

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      URI.open(value)
    rescue
      record.errors[attribute] << (options[:message] || "#{value} is not a valid URL")
    end
  end
end