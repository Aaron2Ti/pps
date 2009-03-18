class UsersController < ApplicationController
  before_filter :require_login, :only => [:show, :edit]
  def new
    @user = User.new
  end

  def create
    User.create!(params[:user])
    redirect_to account_url
  rescue
    @user = User.new
    render :action => :new
  end

  def show
    @user = current_user

    respond_to do |format|
      format.html
      format.js {render :js => 'alert();'}
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes!(params[:user])
    redirect_to edit_account_url
  rescue
    render :action => :edit
  end
end
