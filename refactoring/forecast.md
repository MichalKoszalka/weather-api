## Code smells

    reek lib\weather-api\forecast.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\forecast.rb -- 2 warnings:
      [2]:IrresponsibleModule: Weather::Forecast has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
      [2]:TooManyInstanceVariables: Weather::Forecast has at least 6 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)

    module Weather
      class Forecast
        # the brief name of the day associated with the forecast
        attr_reader :day
    
        # the date associated with the forecast.
        attr_reader :date
    
        # the low temperature forecasted.
        attr_reader :low
    
        # the high temperature forecasted.
        attr_reader :high
    
        # the brief prose text description of the forecasted weather conditions.
        attr_reader :text
    
        # the weather condition code, detailed at http://developer.yahoo.com/weather
        attr_reader :code
    
        def initialize(payload)
          @day  = payload[:day].strip
          @date = Utils.parse_time payload[:date]
          @low  = payload[:low].to_i
          @high = payload[:high].to_i
          @text = payload[:text]
          @code = payload[:code].to_i
        end
      end
    end

`class Forecast` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather
      # Class containing weather for specific day
      class Forecast
        # the brief name of the day associated with the forecast
        attr_reader :day
    
        # the date associated with the forecast.
        attr_reader :date
    
        # the low temperature forecasted.
        attr_reader :low
    
        # the high temperature forecasted.
        attr_reader :high
    
        # the brief prose text description of the forecasted weather conditions.
        attr_reader :text
    
        # the weather condition code, detailed at http://developer.yahoo.com/weather
        attr_reader :code
    
        def initialize(payload)
          @day  = payload[:day].strip
          @date = Utils.parse_time payload[:date]
          @low  = payload[:low].to_i
          @high = payload[:high].to_i
          @text = payload[:text]
          @code = payload[:code].to_i
        end
      end
    end

Done
