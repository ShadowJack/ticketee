class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(name: params[:signin][:name]).first

    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Signed in successfully.'

      redirect_to root_path
    else
      flash[:error] = 'Sorry.'
      render :action => "new"
    end
  end
end
