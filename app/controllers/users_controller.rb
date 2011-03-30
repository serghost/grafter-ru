class UsersController < ApplicationController
  before_filter :authorize_admin!, :except => [:show]
  before_filter :authenticate_user!, :only => [:show]
  before_filter :find_user, :only => [:reset, :give, :edit, :update]

  def show
  end

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User has been updated."
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

  private

  def find_user
    @user = User.find params[:id]
  end
end
