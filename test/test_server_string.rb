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
  
  def test_set
    @db.set "foo", "bar"
    assert_equal "bar", @db.get("foo")
  end
  
  def test_set_on_hash
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => "Cannot perform string/numeric operation on non-string/numeric value"}, @db.set("foo", "bar"))
  end
  
  def test_get_on_hash
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => "Cannot perform string/numeric operation on non-string/numeric value"}, @db.get("foo"))
  end
  
  def test_append_empty
    @db.append "foo", "bar"
    assert_equal "bar", @db.get("foo")
  end
  
  def test_append_present
    @db.set "foo", "lol"
    @db.append "foo", "cat"
    assert_equal "lolcat", @db.get("foo")
  end
  
  def test_append_number
    @db.set "foo", 42
    assert_equal({"error" => "Cannot perform string operation on non-string value"}, @db.append("foo", "bar"))
  end
  
  def test_incr
    @db.set "foo", 2
    @db.incr "foo"
    assert_equal 3, @db.get("foo")
  end
  
  def test_incr_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform numeric operation on non-numeric value"}, @db.incr("foo"))
  end
  
  def test_decr
    @db.set "foo", 2
    @db.decr "foo"
    assert_equal 1, @db.get("foo")
  end
  
  def test_decr_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform numeric operation on non-numeric value"}, @db.decr("foo"))
  end
  
  def test_incrby
    @db.set "foo", 2
    @db.incrby "foo", 2
    assert_equal 4, @db.get("foo")
  end
  
  def test_incrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform numeric operation on non-numeric value"}, @db.incrby("foo", 2))
  end
  
  def test_decrby
    @db.set "foo", 2
    @db.decrby "foo", 2
    assert_equal 0, @db.get("foo")
  end
  
  def test_decrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => "Cannot perform numeric operation on non-numeric value"}, @db.decrby("foo", 2))
  end
  
end