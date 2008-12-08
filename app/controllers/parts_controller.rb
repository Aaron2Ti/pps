class PartsController < ApplicationController
  def index
    @parts = Part.all
  end

  def new
    @part = Part.new
  end
  
  def create
    @part = Part.create!(params[:part])
    redirect_to part_path(@part) 
  end

  def edit
    @part = Part.find(params[:id])
  end

  def update
    @part = Part.find(params[:id])
    @part.update_attributes!(params[:part])
    redirect_to part_path(@part) 
  end

  def show
    @part = Part.find(params[:id])
    respond_to do |format|
      format.html
      format.sldprt {
        send_file 'public' + @part.public_filename
      }
    end
 end

  def destroy
    Part.destroy(params[:id])
    redirect_to parts_path
  end
end
