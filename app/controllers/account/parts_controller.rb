class Account::PartsController < ApplicationController
  def index
    @owner = current_user
    @parts = @owner.parts.all(:limit => 8)
#    render :template => 'parts/index'
#    render(:controller => 'Part', :action => 'index')
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.create!(params[:part])
    redirect_to account_parts_path
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    @part.update_attributes!(params[:part])
    redirect_to account_parts_path
  end

  def show
    @part = Part.find(params[:id], :include => [:parameters])
  end

  def destroy
    Part.destroy(params[:id])
    redirect_to parts_path
  end

  def change
    @part = Part.find(params[:id])
    @part.change(params[:parameters]) if params[:parameters].size > 0
    redirect_to part_url(@part)
  end
end
