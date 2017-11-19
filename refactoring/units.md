## Code smells

    reek lib\weather-api\units.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\units.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Units has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    
    module Weather
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
    
`class Units` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

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

Done
