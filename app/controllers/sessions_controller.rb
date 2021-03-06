class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
  # Find user exist or not
    user = User.find_by(email: params[:session][:email].downcase)
    #Authenticate 
    if user&.authenticate(params[:session][:password])
      flash[:infor] = "Login sucess!"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "Email or password is not valid"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
