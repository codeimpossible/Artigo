require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users, :posts

  test "non-logged in user cannot access index" do	
	get :index
    assert_redirected_to :controller => '/session', :action => 'new'
  end
  
  test "logged-in user can access index" do
	login_as :quentin
	get :index
	assert_response :success
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

  test "should get edit" do
    login_as :quentin
    get :edit, :id => posts(:one).id
    assert_response :success
  end

  test "should update post" do
    login_as :quentin
    put :update, :id => posts(:one).id, :post => { }
    assert_redirected_to :controller => 'posts', :action => 'index'
  end

  test "should destroy post" do
    login_as :quentin
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).to_param
    end

    assert_redirected_to root_path
  end
end
