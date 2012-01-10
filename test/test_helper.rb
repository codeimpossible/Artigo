ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path('../../lib/authenticated_test_helper', __FILE__)
require 'rails/test_help'

# Travis CI Testing Environtment Setup
configs = YAML.load_file('test/database.yml')
ActiveRecord::Base.configurations = configs

db_name = ENV['DB'] || 'sqlite'
ActiveRecord::Base.establish_connection(db_name)
ActiveRecord::Base.default_timezone = :utc

class ActiveSupport::TestCase
  include AuthenticatedTestHelper
  fixtures :all

  def as(user)
    login_as user
    yield if block_given?
  end

  #
  # Unit test memory optimizations
  # Courtesy Jamis @ 37Signals
  # http://37signals.com/svn/posts/2742-the-road-to-faster-tests
  #
  unless defined?(DEFERRED_GC_THRESHOLD)
    setup :begin_gc_deferment
    teardown :reconsider_gc_deferment

    DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || 1.0).to_f

    @@last_gc_run = Time.now

    def begin_gc_deferment
      GC.disable if DEFERRED_GC_THRESHOLD > 0
    end

    def reconsider_gc_deferment
      if DEFERRED_GC_THRESHOLD > 0 && Time.now - @@last_gc_run >= DEFERRED_GC_THRESHOLD
        GC.enable
        GC.start
        GC.disable

        @@last_gc_run = Time.now
      end
    end

    teardown :scrub_instance_variables

    @@reserved_ivars = %w(@loaded_fixtures @test_passed @fixture_cache @method_name @_assertion_wrapped @_result)

    def scrub_instance_variables
      (instance_variables - @@reserved_ivars).each do |ivar|
        instance_variable_set(ivar, nil)
      end
    end
  end
end
