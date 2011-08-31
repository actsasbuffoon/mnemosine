module HashTest
  def test_hset
    @db.hset "foo", "bar", "baz"
    assert_equal "baz", @db.hget("foo", "bar")
  end
  
  def test_hset_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hset("foo", "bar", "baz"))
  end
  
  def test_hget_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hget("foo", "bar"))
  end
  
  def test_hkeys
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    assert_equal ["bar", "lol"], @db.hkeys("foo").sort
  end
  
  def test_hkeys_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hkeys("foo"))
  end
  
  def test_hdel
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    @db.hdel "foo", "bar"
    assert_equal ["lol"], @db.hkeys("foo")
  end
  
  def test_hdel_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hdel("foo", "bar"))
  end
  
  def test_hexists
    @db.hset "foo", "bar", "baz"
    assert_equal false, @db.hexists("foo", "lol")
    assert_equal true, @db.hexists("foo", "bar")
  end
  
  def test_hexists_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hexists("foo", "bar"))
  end
  
  def test_hlen
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    assert_equal 2, @db.hlen("foo")
  end
  
  def test_hlen_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hlen("foo"))
  end
  
  def test_hgetall
    @db.hset "foo", "bar", "baz"
    @db.hset "foo", "lol", "cat"
    assert_equal({"bar" => "baz", "lol" => "cat"}, @db.hgetall("foo"))
  end
  
  def test_hgetall_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hgetall("foo"))
  end
  
  def test_hincr
    @db.hset "foo", "bar", 2
    @db.hincr "foo", "bar"
    assert_equal 3, @db.hget("foo", "bar")
  end
  
  def test_hincr_hash_string
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @numeric_only_message}, @db.hincr("foo", "bar"))
  end
  
  def test_hincr_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hincr("foo", "bar"))
  end
  
  def test_hdecr
    @db.hset "foo", "bar", 2
    @db.hdecr "foo", "bar"
    assert_equal 1, @db.hget("foo", "bar")
  end
  
  def test_hdecr_hash_string
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @numeric_only_message}, @db.hdecr("foo", "bar"))
  end
  
  def test_hdecr_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hdecr("foo", "bar"))
  end
  
  def test_hincrby
    @db.hset "foo", "bar", 2
    @db.hincrby "foo", "bar", 2
    assert_equal 4, @db.hget("foo", "bar")
  end
  
  def test_hincrby_hash_string
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @numeric_only_message}, @db.hincrby("foo", "bar", 2))
  end
  
  def test_hincrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hincrby("foo", "baz", 2))
  end
  
  def test_hdecrby
    @db.hset "foo", "bar", 2
    @db.hdecrby "foo", "bar", 2
    assert_equal 0, @db.hget("foo", "bar")
  end
  
  def test_hdecrby_hash_string
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => @numeric_only_message}, @db.hdecrby("foo", "bar", 2))
  end
  
  def test_hdecrby_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hdecrby("foo", "bar", 2))
  end
  
  def test_hmset_and_get
    @db.hmset "foo", {"bar" => "baz", "lol" => "cat"}
    assert_equal({"bar" => "baz", "lol" => "cat"}, @db.hmget("foo"))
  end
  
  def test_hmset_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hmset("foo", {"bar" => "baz", "lol" => "cat"}))
  end
  
  def test_hmget_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hmget("foo"))
  end
  
  def test_hsetnx
    @db.hsetnx("foo", "bar", "baz")
    assert_equal("baz", @db.hget("foo", "bar"))
  end
  
  def test_hsetnx_on_string
    @db.set "foo", "bar"
    assert_equal({"error" => @hash_only_message}, @db.hsetnx("foo", "bar", "baz"))
  end
  
  def test_hsetnx_taken
    @db.hset "foo", "bar", "baz"
    assert_equal({"error" => "That key is already assigned"}, @db.hsetnx("foo", "bar", "lol"))
  end
  
end