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
    
  end
end