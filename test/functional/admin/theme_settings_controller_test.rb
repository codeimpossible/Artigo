require 'test_helper'

class Admin::ThemeSettingsControllerTest < ActionController::TestCase
  test "logged in user can view edit" do
  	login_as(:quentin)
    get :edit, { 'theme' => "codeimpossible" } #how can we inject a test theme here?
    assert_response :success
  end

  test "non-logged in user cannot view edit" do
	  get :edit, { 'theme' => 'codeimpossible' }
	  assert_redirected_to login_path
  end

  test "non-logged in user cannot view save" do
	  post :save, { 'theme' => 'codeimpossible' }
	  assert_redirected_to login_path
  end

  test "logged in user can save" do
  	login_as(:quentin)
      post :save, {
  		'theme' => 'test',
  		'testing' => 'myvalue'
  	}
    assert_redirected_to :action => "edit"
  end

  test "settings are saved" do
  	login_as(:quentin)
      post :save, {
  		'theme' => 'test',
  		'testing' => 'myvalue'
  	}

  	settings = ThemeSetting.for_theme("test")

  	assert_equal "testing", settings.first.name
  end

  test "GET should fail to save action" do
  	login_as(:quentin)
  	get :save, {
  		'theme' => 'test',
  		'testing' => 'myvalue'
  	}
  	assert_redirected_to :controller => '/application', :action => 'render_404'
  end

  test "theme can be changed" do
    expected_theme = (0...8).map{65.+(rand(25)).chr}.join
    as :quentin do
      post :choose, :theme => expected_theme

      actual_theme = Artigo.get_conf "app_theme"
      assert_equal expected_theme, actual_theme
    end
  end

end
