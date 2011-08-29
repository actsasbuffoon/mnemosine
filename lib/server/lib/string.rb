class Mnemosine
  class Server
    
    def append(k, v)
      if exists(k)
        if @storage[k].class == String
          @storage[k] += v
        else
          {"error" => "The value is not a string"}
        end
      else
        set k, v
      end
    end
    
    def incr(k)
      if @storage[k].class == Fixnum
        @storage[k] += 1
      else
        {"error" => "The value is not a number"}
      end
    end
    
    def decr(k)
      if @storage[k].class == Fixnum
        @storage[k] -= 1
      else
        {"error" => "The value is not a number"}
      end
    end
    
    def incrby(k, v)
      if @storage[k].class == Fixnum
        @storage[k] += v
      else
        {"error" => "The value is not a number"}
      end
    end
    
    def decrby(k, v)
      if @storage[k].class == Fixnum
        @storage[k] -= v
      else
        {"error" => "The value is not a number"}
      end
    end
    
  end
end