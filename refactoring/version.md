## Code smells

    reek lib\weather-api\version.rb
    Inspecting 1 file(s):
    S
    
    lib\weather-api\version.rb -- 1 warning:
      [1]:IrresponsibleModule: Weather has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]

## Refactorings:

#### 1. [Irresponsible Module](https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md)
    
    module Weather
      VERSION = "1.4.0" unless defined?(Weather::VERSION)
    end

`module Weather` has no descriptive comment

**Solution**: Add descriptive comment  
**Steps:**  
1 Add comment before module. No need to test it.

    # Module for consuming weather API
    module Weather
      VERSION = "1.4.0" unless defined?(Weather::VERSION)
    end

Done
