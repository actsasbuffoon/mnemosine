class Mnemosine
  class Server
    
    def ensure_hash(value, args = {})
      if !args[:empty] && !value
        return {"error" => "Cannot perform that operation on an empty value"}
      elsif !value
        return nil
      elsif value.class != Hash
        return {"error" => "Cannot perform hash operation on non-hash value"}
      end
    end
    
    def hset(k, sk, v)
      ensure_hash(@storage[k], empty: true) || (@storage[k] ||= {}; @storage[k][sk] = v)
    end
    
    def hget(k, sk)
      ensure_hash(@storage[k], empty: true) || (@storage[k][sk])
    end
    
    def hkeys(k)
      ensure_hash(@storage[k], empty: true) || (@storage[k].keys)
    end
    
    def hdel(k, sk)
      ensure_hash(@storage[k], empty: true) || (@storage[k].delete sk)
    end
    
    def hexists(k, sk)
      ensure_hash(@storage[k]) || !!@storage[k][sk]
    end
    
    def hlen(k)
      ensure_hash(@storage[k]) || @storage[k].length
    end
    
  end
end