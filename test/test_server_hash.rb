require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "server", "mnemosine.rb"))

class ServerTest < Test::Unit::TestCase
  
  # When run in lib mode, the database just runs as a Ruby lib in your process rather
  # than starting EventMachine and taking TCP connections. Lib mode is only included
  # to make testing easier. It doesn't make any sense to use the DB in lib mode for
  # normal processing.
  #
  # In order to use Mnemosine properly, use the client. The client tests are in
  # the test_client.rb file.
  
  def setup
    @db = Mnemosine::Server.new(lib: true)
  end
  
  def teardown
    @db.delete_all
  end
  
  def test_hset
    @db.hset "foo", "bar", "baz"
    assert_equal "baz", @db.hget("foo", "bar")
  end
  
  def test_hset_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform hash operation on non-hash value"}, @db.hset("foo", "bar", "baz"))
  end
  
  def test_hget_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform hash operation on non-hash value"}, @db.hget("foo", "bar"))
  end
  
  def test_hkeys
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    assert_equal ["bar", "lol"], @db.hkeys("foo").sort
  end
  
  def test_hkeys_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform hash operation on non-hash value"}, @db.hkeys("foo"))
  end
  
  def test_hdel
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    @db.hdel "foo", "bar"
    assert_equal ["lol"], @db.hkeys("foo")
  end
  
  def test_hdel_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform hash operation on non-hash value"}, @db.hdel("foo", "bar"))
  end
  
end