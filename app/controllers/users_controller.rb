class UsersController < ApplicationController
  before_action :require_authentication
  def show
    @user = User.find(params[:id])
    if @user != Current.user
      redirect_to root_path, alert: 'You are not authorized to view this page.'
    end
    @borrowings = @user.borrowings.where(returned_date: nil)

   end
end