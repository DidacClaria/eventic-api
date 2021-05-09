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
    @user = User.find_by_id!(params[:id])
  end
  def update
    @user = User.find_by_id!(params[:id])
   # if @user.password_reset_sent_at < 2.hours.ago
    #  redirect_to new_password_reset_path, :alert => "Password reset has expired."
    if @user.update(user_params)
      @user.save
      redirect_to "http://localhost:3000/editp" + "/" + @user.id.to_s, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :id, :password_confirmation)
  end

end
