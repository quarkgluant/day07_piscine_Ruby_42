class UsersController < ApplicationController
  before_action :set_user, only: %i(edit update show)

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def index
  end


  def update
    @user.modified_by = current_user.id
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
  end

  def user_edit_params
    params.require(:user).permit(:name, :email, :password, :bio)
  end
end
