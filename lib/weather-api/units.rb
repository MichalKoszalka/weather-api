module Weather
  # Class containig the units corresponding
  # to the information contained in the response
  class Units
    FAHRENHEIT = 'f'
    CELSIUS   = 'c'

    # the unit in which temperature is measured
    # e.g. F for Fahrenheit, and C for Celsius
    attr_reader :temperature

    # the unit in which distance is measured
    # e.g. mi for miles, and km for kilometers
    attr_reader :distance

    # the unit in which pressure is measured
    # e.g in for inches, and cm for centimeters
    attr_reader :pressure

    # the unit in which speed is measured
    # e.g. mph for miles per hour, and kph for kilometers per hour
    attr_reader :speed

    def initialize(payload)
      @temperature = payload[:temperature].strip
      @distance = payload[:distance].strip
      @pressure = payload[:pressure].strip
      @speed = payload[:speed].strip
    end
  end
end
