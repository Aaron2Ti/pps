require 'starling'
require 'singleton'

class JobsQueue
  include Singleton

  STARLING = Starling.new('192.168.6.88:22122')

  def add(job, value)
    STARLING.set job, value
    puts '#' * 40
    puts Time.now.strftime 'Time: %m/%d/%y - %I:%M:%S %p'
    puts "Add a new job: #{job} => #{value}"
    puts '#' * 40 + "\n"
  end

  def get(job = 'Job')
    result = STARLING.get job
    puts '*' * 40
    puts Time.now.strftime 'Time: %m/%d/%y - %I:%M:%S %p'
    puts "Solving a job of #{job} => #{result}"
    puts '*' * 40 + "\n"
    result
  end
end
