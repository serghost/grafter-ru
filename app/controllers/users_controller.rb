class UsersController < ApplicationController
  before_filter :authorize_admin!, :except => [:show, :update]
  before_filter :authenticate_user!, :only => [:show, :update]
  before_filter :find_user_id, :only => [:reset, :give, :edit, :update, :destroy]

  def show
    @user = current_user
  end

  def edit
  end

  def destroy
    unless @user == current_user
      @user.destroy
      redirect_to users_path, :notice => "User has been deleted."
    else
      redirect_to users_path, :notice => "You cannot delete yourself."
    end
  end

  def update
    params[:user][:id] = current_user.id unless current_user.admin?
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update_attributes(params[:user])
      if current_user.admin?
        redirect_to users_path, :notice => "User has been updated."
      else
        redirect_to profile_users_path, :notice => "Profile has been updated."
      end
    else
      flash[:alert] = "User has not been updated."
      render :action => "new"
    end
  end

  def index
    @users = User.order("created_at ASC").page params[:page]
  end

  def reset
    unless @user == current_user
      @user.admin = false
      @user.save

      redirect_to users_path, :notice => "User has no admin rights."
    else
      redirect_to users_path, :notice => "You cannot drop out your admin rights."
    end
  end

  def give
    @user.admin = true
    @user.save

    redirect_to users_path, :notice => "User has admin rights."
  end
end
