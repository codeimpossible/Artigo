class UsersController < ApplicationController
  layout "login"

  # render new.rhtml
  def new
	@count = User.all.size
	if @count == 1
		logger.warn "Someone attempted to access /user/new to create the admin account"
		
		not_found
	else
		@user = User.new
	end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])

    success = @user && @user.save

    if success && @user.errors.empty?
      
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Account created. Enjoy."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

end
