class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.create!(params[:user])
    redirect_back_or_default account_url
  rescue
    render :action => :new
  end

  def show
    @user = current_user
  end
end
