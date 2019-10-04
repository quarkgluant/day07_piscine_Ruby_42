class UsersController < ApplicationController
  before_action :set_user, only: %i(edit update show)

  def edit
    @user = User.find(params[:id])
  end

  def new
    if is_admin?
      @user = User.new
    else
      flash[:alert] =  "Accès non autorisÃ©"
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    complete_user
    if @user.valid?
      @user.skip_confirmation!
      @user.save!
      @user.send_reset_password_instructions
      redirect_to liste_utilisateur_path
    else
      render 'new'
    end
  end

  def index
    redirect_to liste_utilisateur_path
  end

  def reinitmdp
    @user = User.find(params[:format])
    @user.send_reset_password_instructions
    flash[:notice] = 'Courriel de rÃ©initialisation du mot de passe transmis'
    redirect_to liste_utilisateur_path
  end

  def update
    @user.modified_by = current_user.id
    if @user.update(user_params)
      if request.referrer.include? "/users/edit"
        redirect_to root_path
      else
        redirect_to liste_utilisateur_path
      end
    else
      render 'edit'
    end

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
