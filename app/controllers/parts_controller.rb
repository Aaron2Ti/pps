class PartsController < ApplicationController
  def index
    @parts = Part.all(:limit => 8)
    @tags ||= Tag.all
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.create!(params[:part])
    redirect_to parts_path
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    @part.update_attributes!(params[:part])
    redirect_to parts_path
  end

  def show
    @part = Part.find(params[:id], :include => [:parameters])
    @tagging = Tagging.new(:owner => current_user, :taggable => @part)
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

  def tagged
    @parts = Tag.find(params[:tag_ids]).taggings.map{|tagging| Part.find(tagging.taggable_id)}
    @tags ||= Tag.all
    render :action => :index
  end

  def add_tags
    @tag = Tag.find_or_create_by_name(params[:tags])
    Tagging.create!(:tag => @tag,
      :taggable => Part.find(params[:id]),
      :owner => current_user)
    render :text => 'ok'
  end
end
