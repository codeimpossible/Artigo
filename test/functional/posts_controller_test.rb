require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users, :posts

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:model)
  end

  test "should show post" do
    get :show, 
        :slug => posts(:one).to_perm, 
        :year => posts(:one).created_at.year, 
        :month => posts(:one).created_at.month,
        :day => posts(:one).created_at.day

    assert_response :success
  end
end
