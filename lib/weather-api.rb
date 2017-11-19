require 'net/http'
require 'json'
require 'map'

require 'weather-api/astronomy'
require 'weather-api/atmosphere'
require 'weather-api/condition'
require 'weather-api/forecast'
require 'weather-api/image'
require 'weather-api/location'
require 'weather-api/response'
require 'weather-api/units'
require 'weather-api/utils'
require 'weather-api/version'
require 'weather-api/wind'

# Module responsible for calling endpoint to get weather information
module Weather
  class << self
    # Yahoo! Weather info endpoint
    ROOT = "http://query.yahooapis.com/v1/public/yql"

    # Public: Looks up current weather information using WOEID
    #
    # woeid - Int - Where On Earth IDentifier -- unique ID for
    #         location to get weather data for. To find
    #         a WOEID, refer to Yahoo!'s documentation
    #         at http://developer.yahoo.com/weather/
    #
    # unit - system of measurement to use. Two acceptable inputs:
    #        'c' - Celsius/Metric measurements
    #        'f' - Fahrenheit/Imperial measurements.
    #
    #        To make this easier, you can use the Weather::Units::FAHRENHEIT and
    #        Weather::Units::CELSIUS constants. Defaults to Celsius
    #
    # Returns a Weather::Response object containing forecast
    def lookup(woeid, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = create_url(woeid, unit)

      doc = get_response url
      Response.new woeid, url, doc
    end

    private
    def create_url(woeid, unit)
      url = ROOT + "?q=select%20*%20from%20weather.forecast%20"
      url += "where%20woeid%3D#{woeid}%20and%20u%3D'#{unit}'&format=json"
      url
    end

    # Public: Looks up current weather information using a location string
    #
    # location - String - A location name.  'City, state, country'
    #         Examples:  Nome, AK
    #                    San Francisco, CA, USA
    #                    Berlin, Germany
    #                    toronto, ca
    #
    # unit - system of measurement to use. Two acceptable inputs:
    #        'c' - Celsius/Metric measurements
    #        'f' - Fahrenheit/Imperial measurements.
    #
    #        To make this easier, you can use the Weather::Units::FAHRENHEIT and
    #        Weather::Units::CELSIUS constants. Defaults to Celsius
    #
    # Returns a Weather::Response object containing forecast
    def lookup_by_location(location, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = create_url_by_location(location, unit)

      doc = get_response url
      Response.new location, url, doc
    end

    private
    def create_url_by_location(location, unit)
      # per the documentation here: https://developer.yahoo.com/weather/
      # can look up the woeid via geo places api from location
      url = ROOT + "?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{location}') and u='#{unit}'&format=json"
      url = URI.escape(url)
      url
    end

    private
    def get_response url
      response = get_http_response_from_url(url)

      response = Map.new(JSON.parse(response))[:query][:results][:channel]

      if response.nil? || !response.respond_to?(:title) || response.title.match(/error/i)
        raise "Failed to get weather [url=#{url}]."
      end

      response
    end

    private
    def get_http_reponse_from_url url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
        response
      rescue => exception
        raise "Failed to get weather [url=#{url}, e=#{exception}]."
      end
    end
  end
end
