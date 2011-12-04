class Admin::BaseController < ApplicationController
    before_filter :login_required
    layout 'admin'
end