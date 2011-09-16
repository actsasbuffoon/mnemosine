class Mnemosine
  class Server
    
    def delete_all
      @storage = new_storage
    end
    
    def delete(k)
      @storage.delete(k)["value"]
    end
    
    def keys
      @storage.keys
    end
    
    def exists(k)
      !!get!(k)
    end
    
    def randomkey
      @storage.keys[rand * @storage.keys.length]
    end
    
    def rename(old_key, new_key)
      @storage[new_key] = get!(old_key)
      delete(old_key)
    end
    
    def renamenx(old_key, new_key)
      if exists(new_key)
        {"error" => "That key is already assigned"}
      else
        rename old_key, new_key
      end
    end
    
    def select_keys(src = nil)
      if src
        p = eval(src)
        @storage.select {|k, v| p.call(k, v["value"])}.map(&:first)
      elsif block_given?
        @storage.select {|k, v| yield(k, v["value"])}.map(&:first)
      end
    end
    
    def match_keys(regex, opts = "")
      if regex.class == String
        rgx = Regexp.new(regex, opts)
        @storage.keys.select {|k| k =~ rgx}
      else
        @storage.keys.select {|k| k =~ regex}
      end
    end
    
  private
    
    def get!(k)
      @storage[k]
    end
    
  end
end