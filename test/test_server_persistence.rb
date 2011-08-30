require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "server", "mnemosine.rb"))

class ServerPersistenceTest < Test::Unit::TestCase
  
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
end