## Code smells

    lib\weather-api.rb -- 8 warnings:
      [87, 87, 87]:FeatureEnvy: Weather#get_response refers to 'response' more than self (maybe move it to another class?) [https://github.com/troessner/reek/blob/master/docs/Feature-Envy.md]
      [17]:IrresponsibleModule: Weather has no descriptive comment [https://github.com/troessner/reek/blob/master/docs/Irresponsible-Module.md]
      [87]:ManualDispatch: Weather#get_response manually dispatches method call [https://github.com/troessner/reek/blob/master/docs/Manual-Dispatch.md]
      [87]:NilCheck: Weather#get_response performs a nil-check [https://github.com/troessner/reek/blob/master/docs/Nil-Check.md]
      [78]:TooManyStatements: Weather#get_response has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
      [37]:TooManyStatements: Weather#lookup has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
      [64]:TooManyStatements: Weather#lookup_by_location has approx 6 statements [https://github.com/troessner/reek/blob/master/docs/Too-Many-Statements.md]
      [81]:UncommunicativeVariableName: Weather#get_response has the variable name 'e' [https://github.com/troessner/reek/blob/master/docs/Uncommunicative-Variable-Name.md]
                         
## Refactorings:

#### 1. To Many Statements ([Long Method](https://refactoring.guru/smells/long-method))

    def lookup(woeid, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = ROOT + "?q=select%20*%20from%20weather.forecast%20"
      url += "where%20woeid%3D#{woeid}%20and%20u%3D'#{unit}'&format=json"

      doc = get_response url
      Response.new woeid, url, doc
    end
    
Method `lookup` has approx 6 statements.

**Solution**: [Extract method](https://refactoring.guru/extract-method)  
**Steps:**  
1 Introduce new method. Run tests.

    def lookup(woeid, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = ROOT + "?q=select%20*%20from%20weather.forecast%20"
      url += "where%20woeid%3D#{woeid}%20and%20u%3D'#{unit}'&format=json"

      doc = get_response url
      Response.new woeid, url, doc
    end
    
    private
    def create_url(woeid, unit)

    end
    
2 Copy the relevant code fragment to your new method.  
 Delete the fragment from its old location and put a call for the new method there instead.  
 Run tests.
 
    def lookup(woeid, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = create_url(woeid, unit)

      doc = get_response url
      Response.new woeid, url, doc
    end

    private
    def create_url(woeid, unit)
      url = ROOT + "?q=select%20*%20from%20weather.forecast%20"
      url += "where%20woeid%3D#{woeid}%20and%20u%3D'#{unit}'&format=json"
      url
    end
     
3 Done

#### 2. To Many Statements ([Long Method](https://refactoring.guru/smells/long-method))

    def lookup_by_location(location, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      # per the documentation here: https://developer.yahoo.com/weather/
      # can look up the woeid via geo places api from location
      url = ROOT + "?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{location}') and u='#{unit}'&format=json"
      url = URI.escape(url)

      doc = get_response url
      Response.new location, url, doc
    end
    
Method `lookup_by_location` has approx 6 statements.

**Solution**: [Extract method](https://refactoring.guru/extract-method)  
**Steps:**  
1 Introduce new method. Run tests.

    def lookup_by_location(location, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      # per the documentation here: https://developer.yahoo.com/weather/
      # can look up the woeid via geo places api from location
      url = ROOT + "?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{location}') and u='#{unit}'&format=json"
      url = URI.escape(url)

      doc = get_response url
      Response.new location, url, doc
    end
    
    private
    def create_url_by_location(location, unit)
      
    end
    
2 Copy the relevant code fragment to your new method.  
 Delete the fragment from its old location and put a call for the new method there instead.  
 Run tests.
 
    def lookup_by_location(location, unit = Units::CELSIUS)
      acceptable_units = [Units::CELSIUS, Units::FAHRENHEIT]
      unit = Units::CELSIUS unless acceptable_units.include?(unit)

      url = create_url_by_location(location, unit)

      doc = get_response url
      Response.new location, url, doc
    end

    private
    def create_url_by_location(location, unit)
      # per the documentation here: https://developer.yahoo.com/weather/
      # can look up the woeid via geo places api from location
      url = ROOT + "?q=select * from weather.forecast where woeid in (select woeid from geo.places(1) where text='#{location}') and u='#{unit}'&format=json"
      url = URI.escape(url)
      url
    end
     
3 Done

#### 3. To Many Statements ([Long Method](https://refactoring.guru/smells/long-method))

    private
    def get_response url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
      rescue => e
        raise "Failed to get weather [url=#{url}, e=#{e}]."
      end

      response = Map.new(JSON.parse(response))[:query][:results][:channel]

      if response.nil? || !response.respond_to?(:title) || response.title.match(/error/i)
        raise "Failed to get weather [url=#{url}]."
      end

      response
    end
    
Method `get_response` has approx 6 statements.

**Solution**: [Extract method](https://refactoring.guru/extract-method)  
**Steps:**  
1 Introduce new method. Run tests.

    private
    def get_response url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
      rescue => e
        raise "Failed to get weather [url=#{url}, e=#{e}]."
      end

      response = Map.new(JSON.parse(response))[:query][:results][:channel]

      if response.nil? || !response.respond_to?(:title) || response.title.match(/error/i)
        raise "Failed to get weather [url=#{url}]."
      end

      response
    end
    
    private
    def get_http_reponse_from_url url
      
    end
    
2 Copy the relevant code fragment to your new method.  
 Delete the fragment from its old location and put a call for the new method there instead.  
 Run tests.

    private
    def get_response url
      response = get_http_response_from_url(url)

      response = Map.new(JSON.parse(response))[:query][:results][:channel]

      if response.nil? || !response.respond_to?(:title) || response.title.match(/error/i)
        raise "Failed to get weather [url=#{url}]."
      end

      response
    end

    private
    def get_http_reponse_from_url url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
        response
      rescue => e
        raise "Failed to get weather [url=#{url}, e=#{e}]."
      end
    end
     
3 Done

#### 4. [Uncommunicative Variable Name:](https://github.com/troessner/reek/blob/master/docs/Uncommunicative-Variable-Name.md)

    private
    def get_http_reponse_from_url url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
        response
      rescue => e
        raise "Failed to get weather [url=#{url}, e=#{e}]."
      end
    end
    
Method `get_response` has local variable `e`.

**Solution**: Rename  
**Steps:**  
1 Change variable name in all occurrences. Run tests.

    private
    def get_http_reponse_from_url url
      begin
        response = Net::HTTP.get_response(URI.parse url).body.to_s
        response
      rescue => exception
        raise "Failed to get weather [url=#{url}, e=#{exception}]."
      end
    end
    
3 Done

  

 


