class Admin::PasswordsController < Admin::BaseController
  def edit
	
  end
  
  def update
    logger.debug "trying to authenticate user: #{current_user.login}"
    if User.authenticate(current_user.login, params[:old_password])
  		if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
  			current_user.password_confirmation = params[:password_confirmation]
  			current_user.password = params[:password]
  			
  			if current_user.save!
  				flash[:notice] = "Password successfully changed"
  			else
  				flash[:error] = "Password not changed. Both passwords must match."
  			end
  			 
  		else
  			flash[:error] = "Password not changed. Both passwords must match."
  		end
  	else
  		flash[:error] = "Password not changed. Both passwords must match."
  	end
    
    redirect_to :action => "edit"
  end
end
