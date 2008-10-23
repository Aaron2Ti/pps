require 'solidworks'
require 'ftools'
class Paper < ActiveRecord::Base
  def absolute_path
    self.archive.absolute_path
  end
  def absolute_filename
    File.join(absolute_path, self.filename)
  end
  def vrml_filename
    self.filename.sub(/.\w+$/, '.WRL')
    self.id.to_s + '.WRL'
  end
  def relative_vrml_filename
    File.dirname(self.archive.public_filename) + '/' + vrml_filename
  end
  def absolute_vrml_filename
    self.absolute_filename.sub(/.\w+$/, '.WRL').gsub(/\//, '\\')
    (File.dirname(self.absolute_filename) + '/' + vrml_filename).gsub(/\//, '\\') 
  end
end
