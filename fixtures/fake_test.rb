require "test/unit"

class FakeTest < Test::Unit::TestCase
  
  def setup
    @foo = false
  end
  
  def test_should_fails
    assert_equal true, @foo
  end
  
  def test_should_success
    assert true
  end
  
  def test_should_error
    undefined
  end
  
  def test_several_assertions
    assert true
    assert false
  end
  
  def test_should_skip
    skip
  end
  
end
