module PartsHelper
  def vrml(src)
    tag :embed,
      { :src => src,
        :type => 'model/vrml',
        :width => 500, 
        :height => 500,
        :consolemode => 1, 
        :skin => '{46BB95BF-8EB4-481A-A1EF-50D43FC32B9D}' }
  end
end
