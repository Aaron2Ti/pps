class ParametersController < ApplicationController
  def index
    @parameters = Parameter.find(:all,
                  :conditions => ["paper_id = ?", params[:paper_id]] )
    @paper = Paper.find(params[:paper_id])
    session[:paper] = @paper
    render :layout => false
  end
  def new
    @para = Parameter.new
    render :layout => false if request.xhr?
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
    @parameter.paper_id = params[:paper_id]
    if @parameter.save
      flash[:notice] = 'Parameter was successfully created.'
      redirect_to parameters_url(params[:paper_id]) 
    else
      render :action => "new" 
    end
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
