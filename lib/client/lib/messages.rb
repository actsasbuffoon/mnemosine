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
    
    api_methods :set, :get, :delete_all, :delete, :keys, :exists, :rename, :renamenx, :incr, :decr, :incrby, :decrby, :append, :randomkey, :save, :restore, :set_location, :unset_location
    
  end
end