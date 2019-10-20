class SessionsController < ApplicationController


  def new
    redirect_to dashboard_path if logged_in?
  end


  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      log_in(user)
      flash[:success] = "Login Success!"
      redirect_to dashboard_path
    else
      flash[:error] = "Login Error: Your login information was incorrect. Please try again."
      redirect_to login_path
    end
  end


  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    @user = User.from_omniauth(access_token)
    # Access_token is used to authenticate request made from the rails application to the google server
    @user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    @user.google_refresh_token = refresh_token if refresh_token.present?
    if @user.save
      flash[:success] = "Hello #{@user.username}"
      populate_skills_if_empty(@user)
      log_in(@user)
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again."
      redirect_to login_path
    end
  end


  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
  
  
end
