require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
    fixtures :posts
    test "dashboard assigns themes" do
      as :quentin do
        get :index
        assert_not_nil assigns(:themes)
      end
    end

    test "dashboard assigns tags" do
      as :quentin do
        get :index
        assert_not_nil assigns :tags
      end
    end

end
