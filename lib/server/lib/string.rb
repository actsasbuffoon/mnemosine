class Mnemosine
  class Server
    
    def set(k, v)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if vl
        vl["value"] = v
      else
        @storage[k] = {"var_type" => "String", "value" => v.to_s}
      end
      v
    end
  
    def get(k)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      return nil unless vl
      if vl["var_type"] == "String"
        vl["value"]
      else
        {"error"=>"That operation is only valid on: Fixnum, String"}
      end
    end
  
    def append(k, v)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if exists(k)
        get!(k)["value"] += v
      else
        set k, v
      end
    end
  
    def incr(k)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if vl["value"] =~ /^\-?\d+$/
        vl["value"] = (vl["value"].to_i + 1).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
  
    def decr(k)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if vl["value"] =~ /^\-?\d+$/
        vl["value"] = (vl["value"].to_i - 1).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
  
    def incrby(k, v)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if vl["value"] =~ /^\-?\d+$/
        vl["value"] = (vl["value"].to_i + v).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
  
    def decrby(k, v)
      vl = get!(k)
      guard = ensure_string(vl, empty: true)
      return guard if guard
      
      if vl["value"] =~ /^\-?\d+$/
        vl["value"] = (vl["value"].to_i - v).to_s
      else
        {"error"=>"That operation is only valid on: Fixnum"}
      end
    end
    
  end
end