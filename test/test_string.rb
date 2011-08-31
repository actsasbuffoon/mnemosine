module StringTest
  def test_set
    @db.set "foo", "bar"
    assert_equal "bar", @db.get("foo")
  end
  
  def test_set_on_hash
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @string_numeric_only_message}, @db.set("foo", "bar"))
  end
  
  def test_get_on_hash
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @string_numeric_only_message}, @db.get("foo"))
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
    assert_equal({"error" => @string_only_message}, @db.append("foo", "bar"))
  end
  
  def test_incr
    @db.set "foo", 2
    @db.incr "foo"
    assert_equal 3, @db.get("foo")
  end
  
  def test_incr_string
    @db.set "foo", "bar"
    assert_equal({"error" => @numeric_only_message}, @db.incr("foo"))
  end
  
  def test_decr
    @db.set "foo", 2
    @db.decr "foo"
    assert_equal 1, @db.get("foo")
  end
  
  def test_decr_string
    @db.set "foo", "bar"
    assert_equal({"error" => @numeric_only_message}, @db.decr("foo"))
  end
  
  def test_incrby
    @db.set "foo", 2
    @db.incrby "foo", 2
    assert_equal 4, @db.get("foo")
  end
  
  def test_incrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => @numeric_only_message}, @db.incrby("foo", 2))
  end
  
  def test_decrby
    @db.set "foo", 2
    @db.decrby "foo", 2
    assert_equal 0, @db.get("foo")
  end
  
  def test_decrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => @numeric_only_message}, @db.decrby("foo", 2))
  end
  
end