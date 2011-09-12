module ListTest
  
  def test_lset
    @db.lset "foo", 0, "bar"
    assert_equal "bar", @db.lget("foo", 0)
  end
  
  def test_lset_string_key
    assert_equal({"error" => "Key must be an integer"}, @db.lset("foo", "bar", "baz"))
  end
  
  def test_lget_string_key
    assert_equal({"error" => "Key must be an integer"}, @db.lget("foo", "bar"))
  end
  
  def test_lset_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @list_only_message}, @db.lset("foo", 0, "bar"))
  end
  
  def test_lget_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @list_only_message}, @db.lget("foo", 0))
  end
  
  def test_lrange
    @db.lset "foo", 0, "bar"
    @db.lset "foo", 1, "baz"
    assert_equal ["bar", "baz"], @db.lrange("foo", 0, 1)
  end
  
  def test_lrange_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @list_only_message}, @db.lrange("foo", 0, 1))
  end
  
  def test_linsert
    @db.lset "foo", 0, "bar"
    @db.lset "foo", 1, "baz"
    @db.linsert "foo", "baz", "lol"
    assert_equal ["bar", "lol", "baz"], @db.lrange("foo", 0, 2)
  end
  
  def test_linsert_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @list_only_message}, @db.linsert("foo", "bar", "baz"))
  end
  
  def test_linsert_value_not_found
    @db.lset "foo", 0, "bar"
    assert_equal({"error" => "Value to replace not found"}, @db.linsert("foo", "lol", "cat"))
  end
  
end