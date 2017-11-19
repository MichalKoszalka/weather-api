## Code smells

    reek lib\weather-api\location.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\location.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Location has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    
    module Weather
      class Location
        # the name of the city
        attr_reader :city
    
        # the name of the country
        attr_reader :country
    
        # name of the region, such as a state or province
        attr_reader :region
    
        def initialize(payload)
          @city = payload[:city].strip
          @country = payload[:country].strip
          @region = payload[:region].strip
        end
      end
    end
    
`class Location` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather
      # Class containing the geographical
      # names of the requested location
      class Location
        # the name of the city
        attr_reader :city
    
        # the name of the country
        attr_reader :country
    
        # name of the region, such as a state or province
        attr_reader :region
    
        def initialize(payload)
          @city = payload[:city].strip
          @country = payload[:country].strip
          @region = payload[:region].strip
        end
      end
    end

Done
