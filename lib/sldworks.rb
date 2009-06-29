require 'iconv'
require 'fileutils'
require 'win32ole'

module Sldworks
  def close(filename)
    me.CloseDoc filename
  end

  def exit
    me.ExitApp
  end

  def show
    me.Visible = true
  end

  def hide
    me.Visible = false
  end

  def open(file, filetype, &block)
    # file may contain chinese characters
    file =  Iconv.conv('gbk', 'utf-8', file)

    if block_given?
      f = Open(file, filetype)
      f.extend Model if f
      yield f
      close File.basename(file, '.*')
    else
      Open(file, filetype)
    end
  end
end

SolidWorks = WIN32OLE.new 'SldworksAdapter'
SolidWorks.extend Sldworks

##########################################
# This Module extend Solidworks ModelDoc
# TODO add some bundle operations:
# precedure_preview
# change_parameter_value,
# change_parameters_values,
module Model

  # the orientation could be: Front, Top, Left, 3D/Isometric
  def show_view orientation
    orientation = 'Isometric' if orientation == '3D'
    me.ShowNamedView2('*' + orientation, -1)
    me.ViewZoomtofit2
  end

  # returns a Array hold the result
  # the 2nd and 3rd items represent errors and warnings while saving
  # e.g. [true, 0, 0]/[false, 1, 3]
  def save
    Save()
  end

  # generate the wrl and jpgs for preview
  # TODO Currently the drawing seems not in the middle of the generated pics
  def pre_process(tmp_dir)
    FileUtils.rm(tmp_dir) if File.exist?(tmp_dir) && !File.directory?(tmp_dir)
    FileUtils.mkdir(tmp_dir) unless File.directory?(tmp_dir)

    show_view '3D'
    save_as   "#{tmp_dir}/isometric.jpg"
    save_as   "#{tmp_dir}/3d.wrl"

    show_view 'Front'
    save_as   "#{tmp_dir}/front.jpg"

    show_view 'Top'
    save_as   "#{tmp_dir}/top.jpg"

    show_view 'Left'
    save_as   "#{tmp_dir}/left.jpg"
  end


  def save_as(file)
    SaveAs(file)
  end

  def fit_view
    me.ViewZoomtofit2
  end

  def rebuild
    me.EditRebuild3();
  end

  def change(name, value = 10)
    # Name may contain chinese characters
    name =  Iconv.conv('gbk', 'utf-8', name)
    param = me.Parameter(name)
    param.SystemValue = value / 1000.0 if param
  end
end
