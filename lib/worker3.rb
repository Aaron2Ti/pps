require 'fileutils'
require 'rubygems'
require 'active_record'
require 'win32ole'
require "#{File.dirname(__FILE__)}/jobs_queue"
require "#{File.dirname(__FILE__)}/../app/models/paper"
require "#{File.dirname(__FILE__)}/../app/models/part"
require "#{File.dirname(__FILE__)}/../app/models/parameter"

ActiveRecord::Base.establish_connection(
  YAML.load_file("#{File.dirname(__FILE__)}/../config/database.yml")['development']
)

APP_ROOT = '//192.168.6.88/aaron/workspace/pps'
loop do
  params = JobsQueue.instance.get('change_part')
  part = Part.find(params.delete('id'))

  img_dir = "#{APP_ROOT}/public/papers/part_#{part.id}"

  sldworks = WIN32OLE.new 'Sldworks.Application'

#   part.filename = Iconv.conv('gbk', 'utf-8', part.filename)
  drawing = File.join APP_ROOT, part.path, part.filename
  doc = sldworks.OpenDoc drawing, 1
  #
  # change the paper
  #
  params.each do |k, v|
    param_def = part.parameters.find(k).def
    doc.Parameter(param_def).SystemValue = v.to_f / 1000.0
  end

  doc.EditRebuild3
  doc.ShowNamedView2 '*Isometric', -1
  doc.ViewZoomtofit2
  doc.SaveAs3("#{img_dir}/3d.wrl", 0, 0)

  sldworks.CloseDoc File.basename(part.filename)

  sleep 1
end

