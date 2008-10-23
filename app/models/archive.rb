require 'ftools'
require 'encoding_filter'

class Archive < ActiveRecord::Base
  has_many :papers, :dependent => :destroy
  has_many :assembles
  has_many :parts

  validate :validate_upload_file
  after_save :write_file, :unzip
  after_destroy :delete_file

  #validates_as_attachment

  def upload_file=(upload_file)
    # TODO validate content-type and size
    # application/x-zip-compressed
    # size
      @upload_file      = upload_file
      self.filename     = @upload_file.original_filename
#       self.content_type = @upload_file.content_type
#       self.size         = @upload_file.size
  end

  def file_path
    "#{upload_path}/#{filename.u2g}"
  end

  def upload_path
    "#{RAILS_ROOT}/public/uploads/archive_#{id}"
  end

private
  # not belong this model
  def unzip
    require 'zipruby'

    Zip::Archive.open(file_path) do |zip|
      zip.each do |entry|
        File.makedirs("#{upload_path}/tmp")
        File.open("#{upload_path}/tmp/#{entry.name}", 'wb') do |f|
          f.write(entry.read) 
        end
      end
    end
  end

  def write_file
    if @upload_file
      File.makedirs("#{upload_path}")
      File.open(file_path, 'wb') do |f|
        f.write(@upload_file.read) 
      end
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
    FileUtils.rm_rf("#{upload_path}")
  end
end
