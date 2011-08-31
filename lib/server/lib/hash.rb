class Mnemosine
  class Server
    
    def hset(k, sk, v)
      ensure_hash(@storage[k], empty: true) || (@storage[k] ||= {}; @storage[k][sk] = v)
    end
    
    def hget(k, sk)
      ensure_hash(@storage[k], empty: true) || (@storage[k] && @storage[k][sk])
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
    
    def hgetall(k)
      ensure_hash(@storage[k], empty: true) || @storage[k]
    end
    
    def hincr(k, sk)
      ensure_hash(@storage[k]) || ensure_numeric(@storage[k][sk]) || @storage[k][sk] += 1
    end
    
    def hdecr(k, sk)
      ensure_hash(@storage[k]) || ensure_numeric(@storage[k][sk]) || @storage[k][sk] -= 1
    end
    
    def hincrby(k, sk, v)
      ensure_hash(@storage[k]) || ensure_numeric(@storage[k][sk]) || @storage[k][sk] += v
    end
    
    def hdecrby(k, sk, v)
      ensure_hash(@storage[k]) || ensure_numeric(@storage[k][sk]) || @storage[k][sk] -= v
    end
    
    def hmset(k, v)
      ensure_hash(@storage[k], empty: true) || @storage[k] = v
    end
    
    def hmget(k)
      ensure_hash(@storage[k]) || @storage[k]
    end
    
    def hsetnx(k, sk, v)
      if !@storage[k]
        @storage[k] ||= {sk => v}
      else
        g = ensure_hash(@storage[k])
        if g
          g
        elsif !@storage[k][sk]
          @storage[k][sk] = v
        else
          {"error" => "That key is already assigned"}
        end
      end
    end
    
  end
end