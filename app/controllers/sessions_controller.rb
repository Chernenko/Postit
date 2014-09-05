class SessionsController < ApplicationController
  def new #displayng form

  end

  def create
    user = User.where(username: params[:username]).first # .first-  because where returning array
# user = User.find_by(username: params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id]= user.id
      flash[:notice]="welcome, you've logged in."
      redirect_to root_path
    else
      flash[:error] = "There is something wrong with you username or password."
      # if we want to use render :new , use flash,new ,
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id]=nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end
end
