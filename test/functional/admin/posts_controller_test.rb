require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users, :posts
  setup :create_configuration

  test "non-logged in user cannot access index" do
    get :index
    assert_redirected_to login_path
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

  test "permalink path resolves correctly" do
    date = Time.now
    path = post_permalink_path :year => date.year, :month => date.month, :day => date.day, :slug => "Test-Post"

    assert_equal "/#{date.year}/#{date.month}/#{date.day}/Test-Post", path
  end

  test "should create post" do
    login_as :quentin

    assert_difference('Post.count') do
      post :create, :post => { :title => "Test Post Title", :summary => "Test Summary", :body_md => "This is some content" }
    end
  end

  test "when we create a post and an error happens, the error is displayed on the /new view" do
    as(:quentin) do
      post :create, :post => { :title => "Test", :summary => "Sample" }

      p = assigns[:post]

      assert_response :success
      assert p.errors[:body_md]
      assert_template "new"
    end
  end

  test "create post redirects to edit page" do
    login_as :quentin

    post :create, :post => { :title => "Test Post Title",:summary => "Test Summary", :body_md => "This is some content" }

    assert_redirected_to edit_admin_post_path :id => 3
  end

  test "create post with tags redirects to edit page" do
    login_as :quentin

    post :create, :post => {
      :title => "Test Post Title",
      :summary => "Test Summary",
      :body_md => "This is some content",
      :tags => "Test1, Test2, Test3" }

    assert_redirected_to edit_admin_post_path :id => 3
  end

  test "post with content param instead of body reports error" do
    login_as :quentin

    post :create, :post => { :title => "Test Post Title",:summary => "Test Summary", :content => "This is some content" }

    p = assigns :post

    assert p.errors[:body_md]
  end

  test "post with body param fills out body" do
    login_as :quentin

    post :create, :post => { :title => "Test Post Title",:summary => "Test Summary", :body_md => "This is some content" }

    post = Post.find_by_id(3)

    assert_equal "This is some content", post.body_md
    assert_equal "<p>This is some content</p>", post.body
  end

  test "should get edit" do
    login_as :quentin
    get :edit, :id => posts(:one).id
    assert_response :success
  end

  test "should update post" do
    login_as :quentin
    put :update, :id => posts(:one).id, :post => {
      :title => "foo",
      :summary => "bar",
      :body_md => "foobar"
    }

    assert_redirected_to :controller => 'posts', :action => 'index'
  end

  test "should destroy post" do
    login_as :quentin
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).to_param
    end

    assert_redirected_to root_path
  end

  protected
  def create_configuration
    Artigo.set_conf('app_theme', 'codeimpossible')
  end
end
