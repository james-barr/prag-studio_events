class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_correct_user_or_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "You're signed up!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user.destroy
    non_admin_logout
    redirect_to root_path, danger: "User successfully deleted."
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User updated successfully"
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless (current_user? @user)
      redirect_to root_url, alert: "Unauthorized access"
    end
  end

  def require_correct_user_or_admin
    @user = User.find(params[:id])
    unless (current_user? @user) || current_user_admin?
      redirect_to root_url, alert: "Unauthorized access"
    end
  end

  def non_admin_logout
    unless current_user_admin?
      session[:user_id] = nil
    end
  end


end
