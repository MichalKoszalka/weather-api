## Code smells

    reek lib\weather-api\astronomy.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\astronomy.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Astronomy has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)

module Weather
  
    module Weather
      class Astronomy
        # a Time object containing the sunrise time for a location
        attr_reader :sunrise
    
        # a Time object containing the sunset time for a location
        attr_reader :sunset
    
        def initialize(payload)
          @sunrise = Utils.parse_time payload[:sunrise]
          @sunset = Utils.parse_time payload[:sunset]
        end
      end
    end

    
`class Atmosphere` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather
      # Class containing sunrise and sunset
      # information for the requested location
      class Astronomy
        # a Time object containing the sunrise time for a location
        attr_reader :sunrise
    
        # a Time object containing the sunset time for a location
        attr_reader :sunset
    
        def initialize(payload)
          @sunrise = Utils.parse_time payload[:sunrise]
          @sunset = Utils.parse_time payload[:sunset]
        end
      end
    end

Done
