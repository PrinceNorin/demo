class UsersController < ApplicationController
  before_action :signed_in_user_check, except: [:new, :create]
  before_action :redirect_signed_in_user, only: [:new, :create]
  before_action :current_user_check, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html
  
  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'You have successfully signed up.'
      signing_in @user
      respond_with @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      respond_with @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def followers
    @users = User.find(params[:id]).followers.paginate page: params[:page]
    render 'show_follow'
  end
  
  def followings
    @users = User.find(params[:id]).followed_users.paginate page: params[:page]
    render 'show_follow'
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
    end
    
    def current_user_check
      unless params[:id].to_i == session[:user_id]
        flash[:danger] = "You don't have permission to access this page."
        redirect_to root_path
      end
    end
end
