class Mnemosine
  class Server
    
    def set(k, v)
      ensure_string_or_numeric(@storage[k], empty: true) || @storage[k] = v
    end
    
    def get(k)
      ensure_string_or_numeric(@storage[k], empty: true) || @storage[k]
    end
    
    def append(k, v)
      g = ensure_string(@storage[k], empty: true)
      return g if g
      if exists(k)
        @storage[k] += v
      else
        set k, v
      end
    end
    
    def incr(k)
      ensure_numeric(@storage[k]) || @storage[k] += 1
    end
    
    def decr(k)
      ensure_numeric(@storage[k]) || @storage[k] -= 1
    end
    
    def incrby(k, v)
      ensure_numeric(@storage[k]) || @storage[k] += v
    end
    
    def decrby(k, v)
      ensure_numeric(@storage[k]) || @storage[k] -= v
    end
    
  end
end