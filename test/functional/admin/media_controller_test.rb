require 'test_helper'
require 'FileUtils'
require 'digest/md5'

class Admin::MediaControllerTest < ActionController::TestCase
  @@STORAGE = "#{Rails.root}/public/#{MEDIA_FOLDER}"
  def setup
    @media = upload_file "files/lioness.jpg"
    @cat = upload_file "files/cutecat.jpg"
  end

  def teardown
    now = Time.now.strftime('%Y/%m')

    FileUtils.rm_rf @@STORAGE
  end

  test "uploading an image creates a new media entry" do
    assert_difference('Media.count', 1) do
      as :quentin do
        post :create, :file => @media, :name => "test_1"
      end
    end
  end

  test "after uploading an image the user is redirected to the index action" do
    as :quentin do
      post :create, :file => @media, :name => 'test_2'
    end

    assert_redirected_to "/admin/media"
  end

  test "name sent, no errors on media" do
    as :quentin do
      post :create, :file => @cat, :name => 'cutecat.jpg'
    end

    m = assigns[:media]
    assert_equal 0, m.errors.size
  end

  test "user is notified of any errors" do
    as :quentin do
      post :create, :file => @media
    end

    assert_flashes :error
  end

  test "when errors occur the new action is rendered" do
    as :quentin do
      post :create, :file => @media
    end

    assert_template :new
  end

  test "when errors occur user is not redirected" do
    as :quentin do
      post :create, :file => @media
    end

    assert_response :success
  end

  private
  def fixture_file(path)
    fixtures_files_path = "#{Rails.root}/test/fixtures"
    "#{fixtures_files_path}/#{path}"
  end

  def upload_file(path)
    Rack::Test::UploadedFile.new fixture_file(path), "image/jpeg", true
  end
end
