require 'test_helper'

class Admin::TidyupControllerTest < ActionController::TestCase

  test "tidyup index route is recognized" do
    assert_recognizes({
      :controller => "admin/tidyup",
      :action => "index"
    }, :path => "/admin/tidyup")
  end

  test "tidyup index returns success" do
    
    as :quentin do
      get :index

      assert_response :success
    end
  end

  test "tidyposts route is recoginized" do
    assert_recognizes({ 
        :controller => "admin/tidyup", 
        :action => "tidyposts"
      }, {
        :path => "/admin/tidyup/tidyposts",
        :method => "POST"
      })
  end

  test "post_type all removes all posts" do
    as :quentin do
      assert_difference("Post.count", -2) do
        post :tidyposts, :post_type => "all"
      end
    end
  end

  test "tidypost redirects to index action" do
    as :quentin do
      post :tidyposts, :post_type => ""

      assert_redirected_to admin_tidyup_path
    end
  end

  test "tidypost displays flash notice only when posts have been deleted" do
    as :quentin do
      post :tidyposts, :post_type => ""

      assert_nil flash[:notice]
    end
  end

  test "tidyposts displays flash notice when posts are deleted" do
    as :quentin do 
      post :tidyposts, :post_type => "all"

      expected_flash = "All your posts have been removed from the blog"

      assert_equal expected_flash, flash[:notice]
    end
  end
end