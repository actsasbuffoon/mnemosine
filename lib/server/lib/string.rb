class Mnemosine
  class Server
    
    def ensure_string(value, args = {})
      if !args[:empty] && !value
        return {"error" => "Cannot perform that operation on an empty value"}
      elsif !value
        return nil
      elsif value.class != String
        return {"error" => "Cannot perform string operation on non-string value"}
      end
    end
    
    def ensure_numeric(value, args = {})
      if !args[:empty] && !value
        return {"error" => "Cannot perform that operation on an empty value"}
      elsif !value
        return nil
      elsif value.class != Fixnum
        return {"error" => "Cannot perform numeric operation on non-numeric value"}
      end
    end
    
    def ensure_string_or_numeric(value, args = {})
      if !args[:empty] && !value
        return {"error" => "Cannot perform that operation on an empty value"}
      elsif !value
        return nil
      elsif ![Fixnum, String].include?(value.class)
        return {"error" => "Cannot perform string/numeric operation on non-string/numeric value"}
      end
    end
    
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