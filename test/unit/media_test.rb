require 'test_helper'

class MediaTest < ActiveSupport::TestCase
  test "media requires a title" do
    media = Media.create
    assert media.errors[:title].any?
  end

  test "media requires a path" do
    media = Media.create :title => "test"
    assert media.errors[:path].any?
  end

  test "media save requires a title" do
    media = Media.new
    media.save

    assert media.errors[:title].any?
  end

  test "media save requires a path" do
    media = Media.new :title => "test"
    media.save

    assert media.errors[:path].any?
  end

  test "media save with title, path, description will save" do
    assert_difference("Media.count", 1) do
      media = Media.new :title => "test", :description => "test", :path => "test"
      media.save

      assert media.errors.empty?
    end
  end
end
