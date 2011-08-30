class Mnemosine
  class Server
    
    def set(k, v)
      @storage[k] = v
    end
    
    def get(k)
      @storage[k]
    end
    
    def delete_all
      @storage = new_storage
    end
    
    def delete(k)
      @storage.delete k
    end
    
    def keys
      @storage.keys
    end
    
    def exists(k)
      !!@storage[k]
    end
    
    def randomkey
      @storage.keys[rand * @storage.keys.length]
    end
    
    def rename(old_key, new_key)
      @storage[new_key] = delete(old_key)
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
        @storage.select(&p).map(&:first)
      elsif block_given?
        @storage.select {|k, v| yield(k, v)}.map(&:first)
      end
    end
    
  end
end