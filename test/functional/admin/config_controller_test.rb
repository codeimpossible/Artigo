require 'test_helper'

# todo: look into mocking out the configuration item
class Admin::ConfigControllerTest < ActionController::TestCase
  test "non authenticated user is redirected to login" do
    put :update, :newtheme => "wont_work"
    assert_redirected_to login_path
  end

  test "changetheme route is registered correctly" do
    assert_recognizes({:controller => 'admin/config', :action => 'edit'}, {:path => "/admin/config/edit"})
  end

  test "posting to config root calls update action" do
    assert_recognizes({:controller => 'admin/config', :action => 'update'}, {:path => "/admin/config", :method => :post})
  end

  test "config is append only" do
    login_as :quentin
    put :update, :test => "hello"

    assert Artigo::CONFIG.first.count > 1
  end

  test "any setting posted will be saved" do
    login_as :quentin
    put :update, :test_value => "tamara"

    assert_not_nil Artigo.get_conf("test_value")
    assert_equal "tamara", Artigo.get_conf("test_value")
  end

  test "theme can be changed" do
    login_as :quentin
    expected_theme = (0...8).map{65.+(rand(25)).chr}.join
    put :update, :app_theme => expected_theme

    actual_theme = Artigo.get_conf "app_theme"
    assert_equal expected_theme, actual_theme
  end
end
