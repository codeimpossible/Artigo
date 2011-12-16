require 'test_helper'

class Admin::PasswordControllerTest < ActionController::TestCase
    fixtures :users

    @@fail_message = "Password not changed. Both passwords must match."

    test "user enters wrong password: password not changed" do
        login_as(:quentin)
        put :update, :old_password => "wrong_password"

        flash_msg = flash[:error]

        assert_equal @@fail_message, flash_msg
    end

    test "user enters empty password and empty confirmation password: password not changed" do
        login_as(:quentin)
        put :update, 
            :old_password => "monkey", 
            :password => '', 
            :password_confirmation => ''

        flash_msg = flash[:error]

        assert_equal @@fail_message, flash_msg
    end

    test "user enters data correctly: their password is changed" do
        login_as(:quentin)
        put :update, 
            :old_password => "monkey", 
            :password => 'new_monkey', 
            :password_confirmation => 'new_monkey'

        flash_msg = flash[:notice]

        assert_response :redirect
        assert_redirected_to edit_admin_password_path
        assert_equal "Password successfully changed", flash_msg
    end
end
