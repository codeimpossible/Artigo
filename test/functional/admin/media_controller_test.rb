require 'test_helper'

class Admin::MediaControllerTest < ActionController::TestCase
  def setup
    @media = fixture_file_upload('files/lioness.jpg','image/jpeg')
  end

  test "uploading an image creates a new media entry" do
    assert_difference('Media.count', 1) do
      as :quentin do
        post :create, :media => @media, :title => "test"
      end
    end
  end

  test "after uploading an image the user is redirected to the index action" do
    as :quentin do
      post :create, :media => @media, :title => 'test'
    end

    assert_redirected_to "/admin/media"
  end

  test "user is notified of any errors" do
    as :quentin do
      post :create, :media => @media
    end

    assert_flashes :error
  end

  test "when errors occur the new action is rendered" do
    as :quentin do
      post :create, :media => @media
    end

    assert_template :new
  end

  test "when errors occur user is not redirected" do
    as :quentin do
      post :create, :media => @media
    end

    assert_response :success
  end
end