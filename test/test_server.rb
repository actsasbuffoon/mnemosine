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
  
  def test_delete_all
    @db.set "foo", "bar"
    @db.delete_all
    assert_nil @db.get("foo")
  end
  
  def test_delete
    @db.set "foo", "bar"
    assert_equal "bar", @db.delete("foo")
    assert_nil @db.get("foo")
  end
  
  def test_keys
    @db.set "foo", "bar"
    @db.set "lol", "cat"
    assert_equal ["foo", "lol"], @db.keys.sort
  end
  
  def test_exists
    @db.set "foo", "bar"
    assert_equal true, @db.exists("foo")
    assert_equal false, @db.exists("lol")
  end
  
  def test_randomkey
    @db.set "foo", "bar"
    @db.set "lol", "cat"
    assert ["foo", "lol"].include?(@db.randomkey), '"foo" or "lol" expected but was'
  end
  
  def test_rename
    @db.set "foo", "bar"
    @db.rename "foo", "baz"
    assert_nil @db.get "foo"
    assert_equal "bar", @db.get("baz")
  end
  
  def test_renamenx
    @db.set "foo", "bar"
    @db.set "baz", "wut"
    assert_equal "That key is already assigned", @db.renamenx("foo", "baz").values.first
    assert_equal "bar", @db.get("foo")
    assert_equal "wut", @db.get("baz")
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
    assert_equal "The value is not a string", @db.append("foo", "bar").values.first
  end
  
  def test_incr
    @db.set "foo", 2
    @db.incr "foo"
    assert_equal 3, @db.get("foo")
  end
  
  def test_incr_string
    @db.set "foo", "bar"
    assert_equal "The value is not a number", @db.incr("foo").values.first
  end
  
  def test_decr
    @db.set "foo", 2
    @db.decr "foo"
    assert_equal 1, @db.get("foo")
  end
  
  def test_decr_string
    @db.set "foo", "bar"
    assert_equal "The value is not a number", @db.decr("foo").values.first
  end
  
  def test_incrby
    @db.set "foo", 2
    @db.incrby "foo", 2
    assert_equal 4, @db.get("foo")
  end
  
  def test_incrby_string
    @db.set "foo", "bar"
    assert_equal "The value is not a number", @db.incrby("foo", 2).values.first
  end
  
  def test_decrby
    @db.set "foo", 2
    @db.decrby "foo", 2
    assert_equal 0, @db.get("foo")
  end
  
  def test_decrby_string
    @db.set "foo", "bar"
    assert_equal "The value is not a number", @db.decrby("foo", 2).values.first
  end
  
  def test_save
    @db.set "foo", "bar"
    loc = File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))
    assert_equal true, @db.save(loc)
    assert File.exist?(File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))), "expected file to exist, but it does not"
    FileUtils.rm loc
  end
  
  def test_save_without_location
    @db.set "foo", "bar"
    assert_equal "No location given" , @db.save.values.first
  end
  
  def test_save_already_exists
    @db.set "foo", "bar"
    loc = File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))
    @db.save(loc)
    assert_equal "File already exists" , @db.save(loc).values.first
    FileUtils.rm loc
  end
  
  def test_restore
    @db.set "foo", "bar"
    loc = File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))
    @db.save(loc)
    @db.delete "foo"
    @db.restore loc
    assert_equal "bar", @db.get("foo")
    FileUtils.rm loc
  end
  
  def test_restore_no_file
    loc = File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))
    assert_equal "File does not exist", @db.restore(loc).values.first
  end
  
  def test_save_default_location
    loc = File.expand_path(File.join(File.dirname(__FILE__), "..", "test_db.mns"))
    @db.file_location = loc
    assert_equal true, @db.save
    FileUtils.rm loc
  end
  
  def test_select_keys
    @db.set "foo", 3
    @db.set "bar", 12
    @db.set "baz", 9
    @db.set "lol", 28
    @db.set "cat", 17
    assert_equal ["bar", "lol"], @db.select_keys {|k, v| v % 2 == 0}.sort
  end
  
  def test_match
    @db.set "foO", "bar"
    @db.set "bar", "wut"
    assert_equal ["foO"], @db.match_key(/(\w)\1/i)
  end
  
end