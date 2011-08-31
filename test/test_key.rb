module KeyTest
  
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
    assert_equal({"error" => "That key is already assigned"}, @db.renamenx("foo", "baz"))
    assert_equal "bar", @db.get("foo")
    assert_equal "wut", @db.get("baz")
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
    assert_equal ["foO"], @db.match_keys(/(\w)\1/i)
  end
  
end