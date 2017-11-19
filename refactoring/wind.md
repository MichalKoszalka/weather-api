## Code smells

    reek lib\weather-api\wind.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\wind.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Wind has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
      
## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    

    module Weather
      class Wind
        # the temperature, with wind chill factored in
        attr_reader :chill
    
        # the direction of the wind in degrees
        attr_reader :direction
    
        # the windspeed
        attr_reader :speed
    
        def initialize(payload)
          @chill = payload[:chill].to_i
          @direction = payload[:direction].to_i
          @speed = payload[:speed].to_i
        end
      end
    end
`class Wind` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather
      # Class containing the wind information
      # for the requested location
      class Wind
        # the temperature, with wind chill factored in
        attr_reader :chill
    
        # the direction of the wind in degrees
        attr_reader :direction
    
        # the windspeed
        attr_reader :speed
    
        def initialize(payload)
          @chill = payload[:chill].to_i
          @direction = payload[:direction].to_i
          @speed = payload[:speed].to_i
        end
      end
    end

Done
