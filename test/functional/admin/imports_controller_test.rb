require 'test_helper'

class Admin::ImportsControllerTest < ActionController::TestCase
  fixtures :users, :posts
  test "test import with wordpress imports posts into db" do
    xml = fixture_file_upload('files/wordpress-sample.wxr','text/xml')
    assert_difference('Post.count', 3) do
      as :quentin do
        post :create, :export_file => xml, :post_type => "published", :post_date => "original", :import_type => "wordpress"
      end
    end
  end

  test "test successful import redirects user to admin dashboard" do
    xml = fixture_file_upload('files/wordpress-sample.wxr','text/xml')
    
    as :quentin do
      post :create, :export_file => xml, :post_type => "published", :post_date => "original", :import_type => "wordpress"
    end

    assert_redirected_to admin_path
  end
end
