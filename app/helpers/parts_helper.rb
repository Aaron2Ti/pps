# encoding: utf-8
module PartsHelper
  def vrml(src)
    tag :embed,
      { :src         => src,
        :width       => 400,
        :height      => 400,
        :type        => 'model/vrml',
        :ConsoleMode => 0,
        :ContextMenu => false,
        :skin        => '{46BB95BF-8EB4-481A-A1EF-50D43FC32B9D}' }
  end

  def link_to_parameters(part)
    if part.parameters.size > 0
      link_to '参数列表', part_parameters_path(part)
    else
      link_to '新参数', new_part_parameter_path(part)
    end
  end
end
