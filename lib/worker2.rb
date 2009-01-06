require 'rubygems'
require 'active_record'
require "#{File.dirname(__FILE__)}/jobs_queue"
require "#{File.dirname(__FILE__)}/../app/models/paper"
require "#{File.dirname(__FILE__)}/../app/models/part"

ActiveRecord::Base.establish_connection(
  YAML.load_file("#{File.dirname(__FILE__)}/../config/database.yml")['development']
)

loop do
  id = JobsQueue.instance.get('mk_thumb')
  part = Part.find(id)
  part.update_attribute(:available, true)
  part.gen_thumbnail
  sleep 1
#  img_file = File.join(File.dirname(__FILE__), '..', 'public',
#                       File.dirname(part.jpg), 'isometric.jpg')


#  img = Magick::Image.read(img_file).first
#  w, h = img.columns, img.rows
#  l, t, half = 0, 0, (w - h).abs / 2
#  if w > h then l, s = half, h else  t, s = half, w end
#  img.crop(l, t, s, s).scale(140, 140).write(File.join(File.dirname(img_file), 'preview.jpg'))

end

