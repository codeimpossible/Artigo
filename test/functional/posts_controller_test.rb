require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users, :posts

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    login_as :quentin
    get :new
    assert_response :success
  end

  test "should create post" do
    login_as :quentin

    date = Time.now

    assert_difference('Post.count') do
      post :create, :title => "Test Post Title", 
        :summary => "Test Summary", 
        :content => "This is some content"
    end

    assert_redirected_to post_permalink_path :year => date.year, 
						:month => date.month, 
						:day => date.day, 
						:slug => "Test-Post-Title"
  end

  test "should show post" do
    get :show, 
        :slug => posts(:one).to_perm, 
        :year => posts(:one).created_at.year, 
        :month => posts(:one).created_at.month,
        :day => posts(:one).created_at.day

    assert_response :success
  end

  test "should get edit" do
    login_as :quentin
    get :edit, :id => posts(:one).to_param
    assert_response :success
  end

  test "should update post" do
    login_as :quentin
    put :update, :id => posts(:one).to_param, :post => { }
    assert_redirected_to post_permalink_path :year => posts(:one).created_at.year, 
						:month => posts(:one).created_at.month, 
						:day => posts(:one).created_at.day, 
						:slug => posts(:one).permalink
  end

  test "should destroy post" do
    login_as :quentin
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).to_param
    end

    assert_redirected_to root_path
  end
end
