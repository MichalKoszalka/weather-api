## Code smells

    reek lib\weather-api\condition.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\condition.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Condition has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]                        

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)

    module Weather
      class Condition
        # the weather condition code, detailed at http://developer.yahoo.com/weather
        attr_reader :code
    
        # the date and time associated with these conditions.
        attr_reader :date
    
        # the temperature of the location.
        attr_reader :temp
    
        # the brief prose text description of the weather conditions of the location.
        attr_reader :text
    
        def initialize(payload)
          @code = payload[:code].to_i
          @date = Utils.parse_time payload[:date]
          @temp = payload[:temp].to_i
          @text = payload[:text].strip
        end
      end
    end
    
`class Condition` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather 
      # Class detailing the current
      # conditions of the requested location
      class Condition
        # the weather condition code, detailed at http://developer.yahoo.com/weather
        attr_reader :code
    
        # the date and time associated with these conditions.
        attr_reader :date
    
        # the temperature of the location.
        attr_reader :temp
    
        # the brief prose text description of the weather conditions of the location.
        attr_reader :text
    
        def initialize(payload)
          @code = payload[:code].to_i
          @date = Utils.parse_time payload[:date]
          @temp = payload[:temp].to_i
          @text = payload[:text].strip
        end
      end
    end

Done
