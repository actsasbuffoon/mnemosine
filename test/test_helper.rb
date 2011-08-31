require 'test/unit'
require 'FileUtils'

class MnemosineTest < Test::Unit::TestCase
  
  # When run in lib mode, the database just runs as a Ruby lib in your process rather
  # than starting EventMachine and taking TCP connections. Lib mode is only included
  # to make testing easier. It doesn't make any sense to use the DB in lib mode for
  # normal processing.
  #
  # In order to use Mnemosine properly, use the client. The client tests are in
  # the test_client.rb file.
  
  def setup
    @numeric_only_message = "That operation is only valid on: Fixnum"
    @string_only_message = "That operation is only valid on: String"
    @string_numeric_only_message = "That operation is only valid on: Fixnum, String"
    @hash_only_message = "That operation is only valid on: Hash"
  end
  
  def teardown
    @db.delete_all
  end
  
end

require File.expand_path(File.join File.dirname(__FILE__), 'test_key.rb')
require File.expand_path(File.join File.dirname(__FILE__), 'test_string.rb')
require File.expand_path(File.join File.dirname(__FILE__), 'test_hash.rb')
require File.expand_path(File.join File.dirname(__FILE__), 'test_persistence.rb')

require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "server", "mnemosine.rb"))

class ServerTest < MnemosineTest
  
  def setup
    @db = Mnemosine::Server.new(lib: true)
    super
  end
  
  include KeyTest
  include StringTest
  include HashTest
  include PersistenceTest
end

require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "client", "mnemosine.rb"))

class ClientTest < MnemosineTest
  
  def setup
    @db = Mnemosine::Client.new
    super
  end
  
  include KeyTest
  include StringTest
  include HashTest
end