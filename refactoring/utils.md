## Code smells

    reek lib\weather-api\utils.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\utils.rb -- 1 warning:
      [4]:IrresponsibleModule: Weather::Utils has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    
    require 'chronic'
    
    module Weather
      class Utils
    
        # Attempts to convert passed text into a Time object
        #
        # Returns a Time object or nil
        def self.parse_time(text = '')
          if text == ''
            return nil
          end
    
          begin
            Time.parse text
          rescue ArgumentError
            Chronic.parse text
          end
        end
      end
    end

    
`class Utils` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    require 'chronic'
    
    module Weather
      # Utility class with time parser
      class Utils
    
        # Attempts to convert passed text into a Time object
        #
        # Returns a Time object or nil
        def self.parse_time(text = '')
          if text == ''
            return nil
          end
    
          begin
            Time.parse text
          rescue ArgumentError
            Chronic.parse text
          end
        end
      end
    end

Done
