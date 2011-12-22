ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path('../../lib/authenticated_test_helper', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthenticatedTestHelper
  fixtures :all

  def as(user)
    login_as user
    yield if block_given?
  end

  def assert_flashes(type)
    assert_not_nil flash[type]
  end
end
