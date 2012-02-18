require 'test_helper'

class PostsControllerTest < ActionController::IntegrationTest
  test "post body_md should be rendered as html" do
    @p = Post.new :title => "Test Post",
                  :summary => "Summary",
                  :body_md => "## This is a header",
                  :published => true

    @p.save

    date = @p.created_at

    open_session do |browser|
      browser.get "/#{date.year}/#{date.month}/#{date.day}/#{@p.to_perm}"

      browser.assert_select "h2", :text => "This is a header"
    end
  end
end
