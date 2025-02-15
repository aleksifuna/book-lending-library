class RegistrationsController < ApplicationController
    allow_unauthenticated_access
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        start_new_session_for @user
        redirect_to root_path, notice: 'User created successfully'
    else
        flash[:error] = @user.errors.full_messages.join("\n")
        render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end
