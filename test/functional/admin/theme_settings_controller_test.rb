require 'test_helper'

class Admin::ThemeSettingsControllerTest < ActionController::TestCase
  test "logged in user can view edit" do
	login_as(:quentin)
    get :edit, { 'theme' => "codeimpossible" } #how can we inject a test theme here?
    assert_response :success
  end
  
  test "non-logged in user cannot view edit" do
	get :edit, { 'theme' => 'codeimpossible' }
	assert_redirected_to :controller => "/session", :action => "new"
  end
  
  test "non-logged in user cannot view save" do 
	post :save, { 'theme' => 'codeimpossible' }
	assert_redirected_to :controller => "/session", :action => "new"
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
  
end
