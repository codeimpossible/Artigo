require 'test_helper'

require "#{Rails.root}/lib/artigo/importers/wordpress_importer.rb"

class WordpressImporterTest < ActiveSupport::TestCase
  fixtures :users, :posts
  test "test wordpress importer only imports posts" do
    xml = IO.read("#{Rails.root}/test/exports/wordpress-sample.wxr")

    importer = BlogPostImporter.create :wordpress

    assert_difference('Post.count', 3) do
      importer.import xml, :all, :original
    end
  end

  test "test wordpress importer will import drafts" do
    xml = IO.read("#{Rails.root}/test/exports/wordpress-sample3-drafts-only.wxr")

    importer = BlogPostImporter.create :wordpress

    assert_difference('Post.count', 1) do
      importer.import xml, :all, :original
    end
  end
end