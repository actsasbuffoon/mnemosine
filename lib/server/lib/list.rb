class Mnemosine
  class Server
    
    def lset(k, sk, v)
      vl = get!(k)
      guard = ensure_array(vl, empty: true)
      return guard if guard
      
      if sk.class == Fixnum
        @storage[k] ||= {"var_type" => "Array", "value" => []}
        @storage[k]["value"][sk] = v
      else
        {"error"=>"Key must be an integer"}
      end
      
    end
    
    def lget(k, sk)
      vl = get!(k)
      guard = ensure_array(vl, empty: true)
      return guard if guard
      
      if sk.class == Fixnum
        vl["value"][sk]
      else
        {"error"=>"Key must be an integer"}
      end
    end
    
    def lrange(k, start, stop)
      vl = get!(k)
      guard = ensure_array(vl, empty: true)
      return guard if guard
      
      vl["value"][start..stop]
    end
    
    def linsert(k, replace, v)
      vl = get!(k)
      guard = ensure_array(vl, empty: true)
      return guard if guard

      replace_idx = nil
      vl["value"].each.with_index do |val, idx|
        if val == replace
          replace_idx = idx
          break
        end
      end
      replace_idx ? vl["value"].insert(replace_idx, v) : {"error" => "Value to replace not found"}
    end
    
  end
end