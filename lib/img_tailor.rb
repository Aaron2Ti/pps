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
  part.gen_thumbnail
  part.update_attribute(:available, true)
  sleep 1
end

