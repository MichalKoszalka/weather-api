## Files:

 lib/[weather-api.rb](weather-api.md)  
 lib/weather-api/[atmosphere.rb](atmosphere.md)  
 lib/weather-api/[condition.rb](condition.md)  
 lib/weather-api/[forecast.rb](forecast.md)  
 lib/weather-api/[image.rb](image.md)  
 lib/weather-api/[location.rb](location.md)  
 lib/weather-api/[response.rb](response.md)  
 lib/weather-api/[units.rb](units.md)  
 lib/weather-api/[utils.rb](utils.md)  
 lib/weather-api/[version.rb](version.md)  
 lib/weather-api/[wind.rb](wind.md)  
 
 ## Before:
     reek lib/*
     Inspecting 12 file(s):
     SSSSSSSSSSSS
     
     lib/weather-api/astronomy.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Astronomy has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/atmosphere.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Atmosphere has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/condition.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Condition has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/forecast.rb -- 2 warnings:
       [2]:IrresponsibleModule: Weather::Forecast has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
       [2]:TooManyInstanceVariables: Weather::Forecast has at least 6 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
     lib/weather-api/image.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Image has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/location.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Location has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/response.rb -- 4 warnings:
       [65, 69, 71, 75, 76, 77, 78]:DuplicateMethodCall: Weather::Response#initialize calls 'doc[:item]' 7 times [https://github.com/troessner/reek/blob/master/docs/Duplicate-Method-Call.md]
       [65, 78]:DuplicateMethodCall: Weather::Response#initialize calls 'doc[:item][:description]' 2 times [https://github.com/troessner/reek/blob/master/docs/Duplicate-Method-Call.md]
       [2]:IrresponsibleModule: Weather::Response has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
       [2]:TooManyInstanceVariables: Weather::Response has at least 14 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
     lib/weather-api/units.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Units has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/utils.rb -- 1 warning:
       [4]:IrresponsibleModule: Weather::Utils has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/version.rb -- 1 warning:
       [1]:IrresponsibleModule: Weather has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api/wind.rb -- 1 warning:
       [2]:IrresponsibleModule: Weather::Wind has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
     lib/weather-api.rb -- 8 warnings:
       [87, 87, 87]:FeatureEnvy: Weather#get_response refers to 'response' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
       [17]:IrresponsibleModule: Weather has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
       [87]:ManualDispatch: Weather#get_response manually dispatches method call [https://github.com/troessner/reek/blob/master/docs/Manual-Dispatch.md]
       [87]:NilCheck: Weather#get_response performs a nil-check [https://github.com/troessner/reek/blob/master/docs/Nil-Check.md]
       [78]:TooManyStatements: Weather#get_response has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
       [37]:TooManyStatements: Weather#lookup has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
       [64]:TooManyStatements: Weather#lookup_by_location has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
       [81]:UncommunicativeVariableName: Weather#get_response has the variable name 'e' [https://github.com/troessner/reek/blob/master/docs/Uncommunicative-Variable-Name.md]
     23 total warnings
 
 ## After refactorings"
 
    reek lib/*
    Inspecting 12 file(s):
    ...S..S....S
    
    lib/weather-api/forecast.rb -- 1 warning:
      [3]:TooManyInstanceVariables: Weather::Forecast has at least 6 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
    lib/weather-api/response.rb -- 2 warnings:
      [3]:InstanceVariableAssumption: Weather::Response assumes too much for instance variable '@forecasts' [https://github.com/troessner/reek/blob/master/docs/Instance-Variable-Assumption.md]
      [3]:TooManyInstanceVariables: Weather::Response has at least 14 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
    lib/weather-api.rb -- 3 warnings:
      [96, 96, 96]:FeatureEnvy: Weather#get_response refers to 'response' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
      [96]:ManualDispatch: Weather#get_response manually dispatches method call [https://github.com/troessner/reek/blob/master/docs/Manual-Dispatch.md]
      [96]:NilCheck: Weather#get_response performs a nil-check [https://github.com/troessner/reek/blob/master/docs/Nil-Check.md]
    6 total warnings