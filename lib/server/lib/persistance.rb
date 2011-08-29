class Mnemosine
  class Server
    def save(location = nil)
      if location || @file_location
        persist(location || @file_location)
      else
        {"error" => "No location given"}
      end
    end
    
    def save!(location = nil)
      if location || @file_location
        persist!(location || @file_location)
      else
        {"error" => "No location given"}
      end
    end
    
    def restore(location = nil)
      if location || @file_location
        load(location || @file_location)
      else
        {"error" => "No location given"}
      end
    end
    
    def set_location(location)
      @file_location = location
    end
    
    def unset_location
      @file_location = nil
    end
    
    private
    
    def persist(loc)
      if File.exist?(loc)
        {error: "File already exists"}
      else
        persist!(loc)
      end
    end
    
    def persist!(loc)
      File.open(loc, "w") {|f| f.write @storage.to_json}
      true
    end
    
    def load(loc)
      if File.exist? loc
        @storage = JSON.parse(File.read(loc))
      else
        {"error" => "File does not exist"}
      end
    end
    
  end
end