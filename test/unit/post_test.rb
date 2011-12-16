require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should require body for post" do
    p = Post.create(:title => "test")
    assert p.errors[:body]    
  end
end
