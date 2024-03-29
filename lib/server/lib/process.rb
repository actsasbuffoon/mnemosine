class Mnemosine
  class Server
    
    attr_accessor :file_location
    
    API_METHODS = %w[set get delete_all delete keys exists randomkey rename renamenx append incr decr incrby decrby
                     select_keys match_keys hset hget hmset hmget hlen hkeys hincr hincrby hdecr hdecrby hgetall
                     hexists hdel hsetnx]
    
    def initialize(args = {})
      @storage = new_storage
      @port = args[:p] || 4291
      @host = args[:s] || 'localhost'
      unless args[:lib]
        run_loop
      end
    end
    
    def new_storage
      {}
    end
    
    def receive_data(msg)
      return :send_nothing_back if msg == "\n"
      data = JSON.parse(msg)
      k = data.keys.first
      v = data.values.first
      if API_METHODS.include?(k)
        self.send(k, *v)
      else
        {"error" => "#{k} is not an API method"}
      end
    end
    
    def run_loop
      r = Runner
      r.setup(self)
      EventMachine.run do
        EventMachine.start_server @host, @port, r
        puts "Mnemosine listening at #{@host}:#{@port}"
      end
    end
    
    module Runner
      def self.setup(server)
        @@server = server
      end
      
      def receive_data(data)
        puts "Receiving data: #{data.inspect}"
        msg = @@server.receive_data(data)
        unless msg == :send_nothing_back
          puts "Sending msg: #{msg}"
          send_data({val: msg}.to_json + "\n")
          puts "Sent message"
          puts "\n"
        else
          puts "No response"
        end
      end
    end
    
  end
end