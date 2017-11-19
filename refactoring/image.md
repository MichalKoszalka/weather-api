## Code smells

    reek lib\weather-api\image.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\image.rb -- 1 warning:
      [2]:IrresponsibleModule: Weather::Image has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    
    module Weather
      class Image
        # the full URL to the image
        attr_reader :url
    
        def initialize(payload)
          @url = payload.scan(/src=\"(.*)\"/).flatten.first
        end
      end
    end
    
`class Image` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before class. No need to test it.

    module Weather
      # Class containing an image icon
      # representing the current weather for the requested location
      class Image
        # the full URL to the image
        attr_reader :url
    
        def initialize(payload)
          @url = payload.scan(/src=\"(.*)\"/).flatten.first
        end
      end
    end

Done
