require 'ftools'
require 'encoding_filter'

class Archive < ActiveRecord::Base
  has_many :papers, :dependent => :destroy
  has_many :assembles
  has_many :parts

  validate :validate_upload_file
  after_save :write_file, :unzip, :generate_papers
  after_destroy :delete_file

  #validates_as_attachment

  def upload_file=(upload_file)
      @upload_file      = upload_file
      self.filename     = @upload_file.original_filename
      self.content_type = @upload_file.content_type
      self.size         = @upload_file.size
  end

  def path
    "uploads/archive_#{id}"
  end

  def full_path
    File.join RAILS_ROOT, 'public', path
  end

  def file_path
    "#{full_path}/#{filename.u2g}"
  end

  # not belong this model
  def write_file
    if @upload_file
      File.makedirs("#{full_path}")
      File.open(file_path, 'wb') do |f|
        f.write(@upload_file.read) 
      end
    end
  end

  def unzip
    require 'zipruby'
    Zip::Archive.open(file_path) do |zip|
      zip.each do |entry|
        tmp_dir = "#{full_path}/tmp"
        File.makedirs(tmp_dir)
        File.open("#{tmp_dir}/#{entry.name}", 'wb') do |f|
          f.write(entry.read) 
        end
      end
    end
  end

  def generate_papers
    Dir[full_path + '/tmp/*.SLDASM'].each do |e|
      Assemble.create(:archive => self,
                      :filename => File.basename(e).g2u)
    end
    Dir[full_path + '/tmp/*.SLDPRT'].each do |e|
      Part.create(:archive => self,
                  :filename => File.basename(e).g2u)
    end
  end

  def validate_upload_file
    unless @upload_file and
           @upload_file.content_type == 'application/x-zip-compressed' and
           @upload_file.size > 0
      errors.add_to_base('Only Accept ZIP Archives')
    end
  end

  def delete_file
    FileUtils.rm_rf(full_path) if File.exist?(full_path)
  end
end
