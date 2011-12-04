require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
    fixtures :posts
    test "dashboard assigns model" do
      as :quentin do
        get :index
        assert_not_nil assigns(:model) 
      end
    end
end
