## Code smells

    reek lib\weather-api\response.rb
    Inspecting 1 file(s):
    S
                         
    lib\weather-api\response.rb -- 4 warnings:
    [65, 69, 71, 75, 76, 77, 78]:DuplicateMethodCall: Weather::Response#initialize calls 'doc[:item]' 7 times [https://github.com/troessner/reek/blob/master/docs/Duplicate-Method-Call.md]
    [65, 78]:DuplicateMethodCall: Weather::Response#initialize calls 'doc[:item][:description]' 2 times [https://github.com/troessner/reek/blob/master/docs/Duplicate-Method-Call.md]
    [2]:IrresponsibleModule: Weather::Response has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
    [2]:TooManyInstanceVariables: Weather::Response has at least 14 instance variables [https://github.com/troessner/reek/blob/master/docs/Too-Many-Instance-Variables.md]
    
## Refactorings:

#### 1. DuplicateMethodCall ([Feature Envy](https://refactoring.guru/smells/feature-envy))

    def initialize(request_location, request_url, doc)
      # save the request params
      @request_location = request_location
      @request_url      = request_url

      @astronomy  = Astronomy.new doc[:astronomy]
      @location   = Location.new doc[:location]
      @units      = Units.new doc[:units]
      @wind       = Wind.new doc[:wind]
      @atmosphere = Atmosphere.new doc[:atmosphere]
      @image      = Image.new doc[:item][:description]

      @forecasts = []

      @condition  = Condition.new doc[:item][:condition]

      doc[:item][:forecast].each do |forecast|
        @forecasts << Forecast.new(forecast)
      end

      @latitude    = doc[:item][:lat].to_f
      @longitude   = doc[:item][:long].to_f
      @title       = doc[:item][:title].strip
      @description = doc[:item][:description].strip
    end
    
`doc[:item]` being called 7 times to retrieve its value

**Solution**: [Extract method](https://refactoring.guru/extract-method)  
**Steps:**  
1 Introduce new method. Run tests.

     def initialize(request_location, request_url, doc)
       # save the request params
       @request_location = request_location
       @request_url      = request_url
 
       @astronomy  = Astronomy.new doc[:astronomy]
       @location   = Location.new doc[:location]
       @units      = Units.new doc[:units]
       @wind       = Wind.new doc[:wind]
       @atmosphere = Atmosphere.new doc[:atmosphere]
       @image      = Image.new doc[:item][:description]
 
       @forecasts = []
 
       @condition  = Condition.new doc[:item][:condition]
 
       doc[:item][:forecast].each do |forecast|
         @forecasts << Forecast.new(forecast)
       end
 
       @latitude    = doc[:item][:lat].to_f
       @longitude   = doc[:item][:long].to_f
       @title       = doc[:item][:title].strip
       @description = doc[:item][:description].strip
     end
     
     def initialize_from_item(item)
       
     end
     
2 Copy the relevant code fragment to your new method.  
 Delete the fragment from its old location and put a call for the new method there instead.  
 Run tests.
 
     def initialize(request_location, request_url, doc)
       # save the request params
       @request_location = request_location
       @request_url      = request_url
 
       @astronomy  = Astronomy.new doc[:astronomy]
       @location   = Location.new doc[:location]
       @units      = Units.new doc[:units]
       @wind       = Wind.new doc[:wind]
       @atmosphere = Atmosphere.new doc[:atmosphere]
 
       initialize_from_item(doc[:item])
     end
 
     def initialize_from_item(item)
       @image = Image.new item[:description]
 
       @forecasts = []
 
       @condition = Condition.new item[:condition]
 
       item[:forecast].each do |forecast|
         @forecasts << Forecast.new(forecast)
       end
 
       @latitude    = item[:lat].to_f
       @longitude   = item[:long].to_f
       @title       = item[:title].strip
       @description = item[:description].strip
     end
     
Done

#### 1. DuplicateMethodCall ([Feature Envy](https://refactoring.guru/smells/feature-envy))

    def initialize_from_item(item)
      @image = Image.new item[:description]

      @forecasts = []

      @condition = Condition.new item[:condition]

      doc[:item][:forecast].each do |forecast|
        @forecasts << Forecast.new(forecast)
      end

      @latitude    = item[:lat].to_f
      @longitude   = item[:long].to_f
      @title       = item[:title].strip
      @description = item[:description].strip
    end
    
`item[:description]` being called 2 times to retrieve its value

**Solution**: [Extract method](https://refactoring.guru/extract-method)  
**Steps:**  
1 Introduce new method. Run tests.

    def initialize_from_item(item)
      @image = Image.new item[:description]

      @forecasts = []

      @condition = Condition.new item[:condition]

      doc[:item][:forecast].each do |forecast|
        @forecasts << Forecast.new(forecast)
      end

      @latitude    = item[:lat].to_f
      @longitude   = item[:long].to_f
      @title       = item[:title].strip
      @description = item[:description].strip
    end
    
    def initialize_from_description(description)
      
    end
    
2 Copy the relevant code fragment to your new method.  
 Delete the fragment from its old location and put a call for the new method there instead.  
 Run tests.
 
     def initialize_from_item(item)
       @forecasts = []
 
       @condition = Condition.new item[:condition]
 
       item[:forecast].each do |forecast|
         @forecasts << Forecast.new(forecast)
       end
 
       @latitude    = item[:lat].to_f
       @longitude   = item[:long].to_f
       @title       = item[:title].strip
       initialize_from_description(item[:description])
     end
 
     def initialize_from_description(description)
       @image = Image.new description
       @description = description.strip
     end
     
3 Done

  
