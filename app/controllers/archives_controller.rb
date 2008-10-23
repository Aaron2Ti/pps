# require 'encoding_filter'
# require 'ftools'
# require 'zip/zipfilesystem'

class ArchivesController < ApplicationController
  def index
    @archives = Archive.find :all
    render :layout => false if request.xhr?
  end
  def new
    @archive = Archive.new
#     render :layout => false if request.xhr?
  end
  def show
    flash[:archive_id] = params[:id]
    redirect_to papers_path
  end

  def create
    # people upload a zip archive which contains assembles and parts
    Archive.create(params[:archive])
    redirect_to archives_url
#     if @archive.save
#       # extract the archive in its directory
#       Zip::ZipFile.foreach(@archive.absolute_filename) { |zf|
#         zf.extract(@archive.absolute_path + '/' + zf.name)
#       }
#       # each file extracted from archive need to connect to a model.
#       # file with suffix "SLDASM" is a Solidworks Assemble file,
#       # with suffix "SLDPRT" is a Solidworks Part file.
#       # each Assemble is composed of some Parts.
#       Dir[@archive.absolute_path + '/*.SLDASM'].each do |e|
#         assemble = Assemble.create(:filename => File.basename(
#           gbk_to_utf8(e)), :archive_id => @archive.id)
#         gen_vrml(assemble)
#       end
#       Dir[@archive.absolute_path + '/*.SLDPRT'].each do |e|
#         part = Part.create(:filename => File.basename(gbk_to_utf8(e)),
#                     :archive_id => @archive.id)
#         gen_vrml(part)
#       end
#       redirect_to archives_url
#     else
#       render :action => 'new'
#     end
   end
  def destroy
    Archive.destroy(params[:id])
    redirect_to archives_url
  end
  def edit
    @archive = Archive.find(params[:id])
  end
  def update
    Archive.find(params[:id]).update_attributes(params[:archive])
    redirect_to archives_url
  end
  def download
    # zip the Assemble and its Parts
    archive = Archive.find(params[:id])
    tmp_file = utf8_to_gbk(archive.absolute_filename)
    File.delete(tmp_file) if File.exists?(tmp_file)
    Zip::ZipFile.open(tmp_file, Zip::ZipFile::CREATE) do |zf|
      archive.papers.each do |paper| 
        zf.add(utf8_to_gbk(paper.filename), utf8_to_gbk(paper.absolute_filename))
      end
    end
    send_file tmp_file
  end

  private
  def gen_vrml(paper)
    model = solidworks.open_doc(paper)
    model.save_as(paper)
    solidworks.closeDoc utf8_to_gbk(paper.filename)
  end
end
