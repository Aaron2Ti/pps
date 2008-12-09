class ParametersController < ApplicationController
  def index
    @part = Part.find(params[:part_id]) 
    @parameters = @part.parameters
  end

  def new
    @part = Part.find(params[:part_id]) 
    @parameter = Parameter.new(:paper_id => params[:part_id])
  end

  def show
    @parameter = Parameter.find(params[:id])
    render :layout => false if request.xhr?
  end

  def edit
    @parameter = Parameter.find(params[:id])
    render :layout => false if request.xhr?
  end

  def create
    @parameter = Parameter.new(params[:parameter])
    @parameter.paper_id = params[:part_id]
    @parameter.save!
    redirect_to part_parameters_url(params[:part_id]) 
#     if @parameter.save
#       flash[:notice] = 'Parameter was successfully created.'
#       redirect_to parameters_url(params[:paper_id]) 
#     else
#       render :action => "new" 
#     end
  end

  def update
    @parameter = Parameter.find(params[:id])
    if @parameter.update_attributes(params[:parameter])
      flash[:notice] = 'Parameter was successfully updated.'
      redirect_to parameters_url(params[:paper_id]) 
    else
      render :action => "edit" 
    end
  end

  def destroy
    @parameter = Parameter.find(params[:id])
    @parameter.destroy
    redirect_to parameters_url 
  end
end
