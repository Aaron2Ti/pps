class PapersController < ApplicationController
  def index
    @assembles = Assemble.all(:conditions => {:archive_id => params[:archive_id]},
                              :include => :parts)
    @parts = Part.all( :conditions => {
      :archive_id => params[:archive_id], 
      :assemble_id => nil 
    })
    @papers = Paper.all
  end
  
  def show
    @paper = Paper.find params[:id]
#     @vrml = @paper.relative_vrml_filename
#     render :partial => '/partials/preview', :vrml => @vrml
  end

  def edit
    @paper = Paper.find(params[:id])
  end

  def update
    Paper.find(params[:id]).update_attributes(params[:paper])
    redirect_to paper_url(params[:id])
  end

  def change # change paper's parameters
    begin
      @part = Part.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @assemble = Assemble.find params[:id]
    end
    render :layout => false if request.xhr?
  end

  def download
    render :text => 'Send the archive of this paper'
  end

  def rebuild # update all the parameters and rebuild the paper
    case params[:paper_type]
      when 'part' : rebuild_part params
      when 'assemble' : rebuild_assemble params
      else render :text => 'other'
    end
    redirect_to paper_path(params[:id])
  end
private
  def rebuild_part(params)
    part = Part.find(params[:id], :include => [:parameters])
    change_part_parameters(part, params[:parameters])
  end

  def rebuild_assemble(params)
    assemble = Assemble.find(params[:id], :include => [:parts => 'parameters'])
    assemble.parts.each do |part|
      change_part_parameters(part, params[:parameters][part.id.to_s])
    end
    model = solidworks.open_doc(assemble)
    model.save_doc
    model.save_as(assemble)
    solidworks.closeDoc u_to_g(assemble.filename)
  end

  def change_part_parameters(part, parameters)
    model = solidworks.open_doc(part)
    parameters.each do |k,v|
      parameter_name = part.parameters.find(k).name
      model.set_value(u_to_g(parameter_name), v.to_f)
    end if parameters
    model.save_doc
    model.save_as(part)
    solidworks.closeDoc u_to_g(part.filename)
  end
end
