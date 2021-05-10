class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset 
    if user
    render json: {}, status: :ok
    end
  end
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_send_at < 2.hours.ago
       redirect_to "http://localhost:3000/editp" + "/" + @user.password_reset_token, :alert => "Password reset has expired."
    elsif @user.update(user_params)
      @user.save
      redirect_to "http://localhost:3000/editp" + "/" + @user.password_reset_token, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :id, :password_confirmation, :password_reset_token)
  end

end
