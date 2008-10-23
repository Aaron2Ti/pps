class PapersController < ApplicationController
  def index
    if flash[:archive_id]
      @archive = Archive.find(flash[:archive_id],
                              :include => [:parts, :assembles])
      @assembles = @archive.assembles
      @parts = @archive.parts.find(:all, 
                                   :conditions => {:assemble_id => nil}) 
    else
      @assembles = Assemble.find(:all, :include => :parts)
      @parts = Part.find(:all, :conditions => {:assemble_id => nil})
    end
    render :layout => false
  end
  def show
    @paper = Paper.find params[:id]
    @vrml = @paper.relative_vrml_filename
    render :partial => '/partials/preview', :vrml => @vrml
  end
  def edit
    @paper = Paper.find(params[:id])
    render :layout => false if request.xhr?
  end
  def update
    Paper.find(params[:id]).update_attributes(params[:paper])
    redirect_to papers_url
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
    begin
      part = Part.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      assemble = Assemble.find params[:id]
    end
    tmp_file = File.join((assemble || part).absolute_path, "downloads.zip")
    File.delete(tmp_file) if File.exists?(tmp_file)
    if part 
      Zip::ZipFile.open(tmp_file, Zip::ZipFile::CREATE) do |zf|
        zf.add(u_to_g(part.filename), u_to_g(part.absolute_filename))
      end
    elsif assemble
      # a assemble depends on serval parts 
      Zip::ZipFile.open(tmp_file, Zip::ZipFile::CREATE) do |zf|
        zf.add(u_to_g(assemble.filename), u_to_g(assemble.absolute_filename))
        assemble.parts.each do |part| 
          zf.add(u_to_g(part.filename), u_to_g(part.absolute_filename))
        end
      end
    end
    send_file(tmp_file)
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
