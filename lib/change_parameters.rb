require 'ftools'
require 'encoding_filter'
module ChangeParameters
  def abstract_model_filename
    File.join(APP_ROOT, '/public', self.public_filename)
  end
  def full_vrml_filename
    self.full_filename.sub(/\w{6}$/, 'WRL')
  end
  def vrml_filename
    self.public_filename.sub(/\w{6}$/, 'WRL')
  end
  def abstract_vrml_filename
    File.join(APP_ROOT, '/public', self.vrml_filename)
  end
  def change_params(parameters = self.parameters)
    part = solidworks.open_doc(self.abstract_model_filename)
    parameters.each do |k,v|
      k = Iconv.conv('gbk', 'utf-8', k)
      part.setValue(k, v)
    end if parameters
    part.save
    part.saveAs(self.abstract_vrml_filename)
    solidworks.closeDoc self.filename
  end
end
