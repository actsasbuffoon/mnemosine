class Mnemosine
  class Server
    
    def lset(k, sk, v)
      ensure_integer_key(sk) || ensure_array(@storage[k], empty: true) || (@storage[k] ||= []; @storage[k][sk] = v)
    end
    
    def lget(k, sk)
      ensure_integer_key(sk) || ensure_array(@storage[k]) || @storage[k][sk]
    end
    
    def lrange(k, start, stop)
      ensure_array(@storage[k]) || @storage[k][start..stop]
    end
    
    def linsert(k, replace, v)
      g = ensure_array(@storage[k])
      return g if g
      replace_idx = nil
      @storage[k].each.with_index do |val, idx|
        if val == replace
          replace_idx = idx
          break
        end
      end
      replace_idx ? @storage[k].insert(replace_idx, v) : {"error" => "Value to replace not found"}
    end
    
  end
end