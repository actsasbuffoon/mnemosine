class Mnemosine
  class Server
    
    def hset(k, sk, v)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if !vl
        @storage[k] = {"var_type" => "Hash", "value" => {sk.to_s => v.to_s}}
        v.to_s
      elsif vl["var_type"] == "Hash"
        @storage[k]["value"][sk.to_s] = v.to_s
      else
        {"error"=>"That operation is only valid on: Hash"}
      end
    end
    
    def hget(k, sk)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"][sk]
    end
    
    def hkeys(k)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"].keys
    end
    
    def hdel(k, sk)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"].delete sk
    end
    
    def hexists(k, sk)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      !!vl["value"][sk]
    end
    
    def hlen(k)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"].length
    end
    
    def hgetall(k)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"]
    end
    
    def hincr(k, sk)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if vl["value"][sk] =~ /^\d+$/
        vl["value"][sk] = (vl["value"][sk].to_i + 1).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
    
    def hdecr(k, sk)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if vl["value"][sk] =~ /^\d+$/
        vl["value"][sk] = (vl["value"][sk].to_i - 1).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
    
    def hincrby(k, sk, v)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if vl["value"][sk] =~ /^\d+$/
        vl["value"][sk] = (vl["value"][sk].to_i + v).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
    
    def hdecrby(k, sk, v)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if vl["value"][sk] =~ /^\d+$/
        vl["value"][sk] = (vl["value"][sk].to_i - v).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
    
    def hmset(k, v)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if vl
        vl["value"] = v
      else
        @storage[k] = {"var_type" => "Hash", "value" => v}
      end
    end
    
    def hmget(k)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      vl["value"]
    end
    
    def hsetnx(k, sk, v)
      vl = get!(k)
      guard = ensure_hash(vl, empty: true)
      return guard if guard
      
      if !vl
        hset(k, sk, v)
      else
        g = ensure_hash(@storage[k], empty: false)
        if g
          g
        elsif !vl["value"][sk]
          hset k, sk, v
        else
          {"error" => "That key is already assigned"}
        end
      end
    end
    
  end
end