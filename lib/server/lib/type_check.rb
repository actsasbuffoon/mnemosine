class Mnemosine
  class Server
    
    def self.ensure_type(name, classes)
      classes = [classes] unless classes.class == Array
      define_method "ensure_#{name}".to_sym, ->(value, args = {}) do
        if !args[:empty] && !value
          return {"error" => "Cannot perform that operation on an empty value"}
        elsif !value
          return nil
        elsif !classes.include?(value.class)
          return {"error" => "That operation is only valid on: #{classes.map {|c| c.to_s}.sort.join(", ")}"}
        end
      end
    end
    
    ensure_type :hash, Hash
    ensure_type :string, String
    ensure_type :numeric, Fixnum
    ensure_type :string_or_numeric, [String, Fixnum]
    
  end
end