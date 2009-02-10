require 'sldworks'
require 'rubygems'
require 'starling'

# TODO needs clean
APP_ROOT = '//192.168.6.88/aaron/workspace/pps'

STARLING = Starling.new '192.168.6.88:22122'

loop do
  part = Marshal.restore(STARLING.get('process_drawing'))
  drawing = "#{APP_ROOT}/uploads/paper_#{part[:id]}/#{part[:filename]}"
  tmp_dir = "#{APP_ROOT}/public/papers/part_#{part[:id]}"

  case part[:process_type]
  when 'preprocess'
    SolidWorks.open(drawing, 1){ |f| f.pre_process tmp_dir }
    STARLING.set 'mk_thumb', part[:id]
  when 'change'
    SolidWorks.open(drawing, 1) do |f|
      part[:params].each do |param|
        f.change(param[0], param[1])
        f.rebuild
        f.save_as "#{tmp_dir}/3d.wrl"
      end
    end
  else
    puts 'Not Implemented yet!'
  end

  sleep 1
end
