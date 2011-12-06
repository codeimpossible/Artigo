require 'test_helper'

require "#{Rails.root}/lib/artigo/importers/wordpress_importer.rb"

class WordpressImporterTest < ActiveSupport::TestCase
  fixtures :users, :posts
  test "test wordpress importer only imports posts" do
    xml_file = "#{Rails.root}/test/exports/wordpress-sample.wxr"
    with_xml(xml_file) { |i,x|
      assert_difference('Post.count', 3) do
        i.import x, :all, :original
      end
    }
  end

  test "test wordpress importer will import drafts" do
    xml_file = "#{Rails.root}/test/exports/wordpress-sample3-drafts-only.wxr"
    with_xml(xml_file) { |i,x|
      assert_difference('Post.count', 1) do
        i.import x, :all, :original
      end
    }
  end

  test "test wordpress importer with import_type set to :draft, will import only drafts" do
    xml_file = "#{Rails.root}/test/exports/wordpress-sample-one-draft-one-published.wxr"
    with_xml(xml_file) { |i,x|
      assert_difference('Post.count', 1) do
        i.import x, :draft, :original
      end
    }
  end

  test "test wordpress importer with import_type set to :published, will import only published posts" do
    xml_file = "#{Rails.root}/test/exports/wordpress-sample-one-draft-two-published.wxr"
    with_xml(xml_file) { |i,x|
      assert_difference('Post.count', 2) do
        i.import x, :published, :original
      end
    }
  end

  protected
  def with_xml(xml)
    xml = IO.read(xml)

    importer = BlogPostImporter.create :wordpress

    yield(importer, xml) if block_given?
  end
end