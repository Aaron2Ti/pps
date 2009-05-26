class PartsController < ApplicationController
  def index
    @parts = Part.all(:limit => 8)
    @tags = Tag.all(:limit => 15)
    @suppliers = Supplier.all
    @suppliers.sort!{|m, n| m.name.size <=> n.name.size}
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
    @part = Part.find(params[:id], :include => [:parameters, :tags])
    @tagging = Tagging.new(:owner => current_user, :taggable => @part)
  end

  def destroy
    Part.destroy(params[:id])
    redirect_to parts_path
  end

  def change
    @part = Part.find(params[:id])
  end

  def transform
    @part = Part.find(params[:id])
    @part.change(params[:parameters]) if params[:parameters].size > 0
    redirect_to change_part_url(@part)
  end

  def tagged
    #taggings.map{|tagging| Part.find(tagging.taggable_id)}
    @parts = Tag.find(params[:tag_ids]).parts
    @tag = Tag.find(params[:tag_ids])
  end

  def add_tags
    @tag = Tag.find_or_create_by_name(params[:tags])
    Tagging.create!(:tag => @tag,
      :taggable => Part.find(params[:id]),
      :owner => current_user)
    redirect_to part_url(params[:id])
  end
end
