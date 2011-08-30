require 'socket'
require 'json'

class Mnemosine
  class Client
    
    private
    
    def send_data(msg)
      @socket.puts msg.to_json
      JSON.parse(@socket.readline)["val"]
    end
    
    def self.api_methods(*mthds)
      mthds.each do |mthd|
        define_method mthd, ->(*args) do
          send_data({mthd => args})
        end
      end
    end
    public
    
    def initialize
      @socket = TCPSocket.open('localhost', 4291)
    end
    
    api_methods :set, :get, :delete_all, :delete, :keys, :exists, :rename, :renamenx, :incr,
                :decr, :incrby, :decrby, :append, :randomkey, :hset, :hget, :hmset, :hmget,
                :hlen, :hkeys, :hincr, :hincrby, :hdecr, :hdecrby, :hgetall, :hexists, :hdel
    
    def select_keys(&blk)
      send_data({"select_keys" => blk.to_source})
    end
    
    def match_keys(regex)
      send_data({"match_keys" => [regex.source, regex.options]})
    end
    
  end
end