class Mnemosine
  class Server
    
    def self.ensure_type(name, classes, opts = {})
      classes = [classes] unless classes.class == Array
      define_method "ensure_#{name}" do |value, args|
        if !args[:empty] && !value
          {"error" => "Cannot perform that operation on an empty value"}
        elsif !value
          nil
        elsif !classes.map {|c| c.to_s}.include?(value["var_type"])
          {"error" => (opts[:message] || "That operation is only valid on: #{classes.map {|c| c.to_s}.sort.join(", ")}")}
        end
      end
    end
    
    ensure_type(:string, String)
    ensure_type(:hash, Hash)
    ensure_type(:array, Array)
    
  end
end