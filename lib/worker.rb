require 'sldworks'
require 'rubygems'
require 'active_record'

require "#{File.dirname(__FILE__)}/jobs_queue"
require "#{File.dirname(__FILE__)}/../app/models/paper"
require "#{File.dirname(__FILE__)}/../app/models/part"

ActiveRecord::Base.establish_connection(
  YAML.load_file("#{File.dirname(__FILE__)}/../config/database.yml")['development']
)

APP_ROOT = '//192.168.6.88/aaron/workspace/pps'

loop do
  part = Part.find(JobsQueue.instance.get('preprocess_part'))

  # TODO seperate the job to Sldworks or ModelDoc
  # part.preprocessing

  img_dir = "#{APP_ROOT}/public/papers/part_#{part.id}"

#  FileUtils.mkdir img_dir

#  sldworks = WIN32OLE.new 'Sldworks.Application'

  part.filename = Iconv.conv('gbk', 'utf-8', part.filename)
  drawing = File.join(APP_ROOT, part.path, part.filename)
  SolidWorks.open(drawing, 1) do |f|
    f.pre_process img_dir
  end
#  doc = sldworks.OpenDoc drawing, 1

#  doc.ShowNamedView2 '*Isometric', -1
#  doc.ViewZoomtofit2
#  doc.SaveAs3("#{img_dir}/isometric.jpg", 0, 0)
#  doc.SaveAs3("#{img_dir}/3d.wrl", 0, 0)

#  doc.ShowNamedView2 '*Front', -1
#  doc.ViewZoomtofit2
#  doc.SaveAs3("#{img_dir}/front.jpg", 0, 0)

#  doc.ShowNamedView2 '*Top', -1
#  doc.ViewZoomtofit2
#  doc.SaveAs3("#{img_dir}/top.jpg", 0, 0)

#  doc.ShowNamedView2 '*Left', -1
#  doc.ViewZoomtofit2
#  doc.SaveAs3("#{img_dir}/left.jpg", 0, 0)

#  sldworks.CloseDoc File.basename(part.filename)

  part.update_attribute(:available, true)

  # part.preprocessing

  JobsQueue.instance.add 'mk_thumb', part.id

  sleep 1
end
