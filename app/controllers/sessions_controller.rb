class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if authorize?
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Success!"
      redirect_to dashboard_path
    else
      flash[:error] = "WTF BRO? TRY AGAIN"
      redirect_to login_path
    end
  end

  def destroy
    session.delete
    redirect_to root_path
  end
end
