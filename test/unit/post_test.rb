require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should require body for post" do
    p = Post.create(:title => "test")
    assert p.errors[:body]
  end

  test "should correctly encode permalinks" do
    hash = {
      # post title                                      expected permalink
      "Test post"                                   => "Test-post",
      "test-post  99"                               => "test-post-99",
      "test; for semicolons"                        => "test-for-semicolons",
      "test: for colons"                            => "test-for-colons",
      "test::  for double colons and double spaces" => "test-for-double-colons-and-double-spaces",
      'special~!@#$%^&*()_+=-`[]{}\\|/?><,.;\':'    => "special", #urls shouldn't end with spec chars
      "double--hyphens--test--"                     => "double-hyphens-test"
    }

    post = Post.new
    hash.each { |title,expected|
      post.title = title
      assert_equal expected, post.to_perm
    }
  end
end
