class UsersController < ApplicationController
  before_filter :require_login, :only => [:show, :edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.login = params[:user][:login]
    @user.save!
    redirect_to account_url
  rescue
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
