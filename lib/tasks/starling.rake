namespace :starling do
  desc 'start starling for this app'
  task :start do
    puts 'Starling starting...'
    `starling -d -q tmp/spool/starling -P tmp/pids/starling.pid`
    puts 'Starling started'
  end

  task :stop do
    if File.exist? 'tmp/pids/starling.pid'
      puts 'Starling stoping...'
      `cat tmp/pids/starling.pid | xargs kill`
      puts 'Starling terminated'
    else
      puts 'Starling not running'
    end
  end

  task :restart => [:stop, :start]
end
