require 'ftools'

class Part < Paper
  # SolidWorks Part's MimeType is 'application/presentations' or 'image/x-presentations'
  # 'application/octet-stream' 
  #   attr_accessible :desc
  #   has_attachment :storage => :file_system,
  #                  :content_type => 'application/octet-stream' 
  #   validates_as_attachment
  #   belongs_to :archive  
  #   belongs_to :assemble  
  has_many :parameters, :foreign_key => 'paper_id', :dependent => :destroy

  after_create :write_file, :preprocess #, :unzip, :generate_papers
  after_destroy :delete_file

  validates_format_of :filename, :with => /^.+\.SLDPRT$/i, :on => :create, 
    :message => 'Only Accept SolidWork\'s Part Drawing Currently'
  validates_inclusion_of :size, :in => 1.kilobyte..5.megabytes, :on => :create,
    :message => 'Only Accept File Size Between 1KB and 5MB'
  validates_presence_of :desc

  def upload_file=(file)
    unless file.blank?
      @upload_file      = file 
      self.filename     = @upload_file.original_filename
      self.content_type = @upload_file.content_type
      self.size         = @upload_file.size
    end
  end

  def path
    "uploads/paper_#{id}"
  end

  def write_file
    if @upload_file
      File.makedirs(path)
      File.open(file_path, 'wb') do |f|
        f.write(@upload_file.read) 
      end
    end
  end

  def delete_file
    FileUtils.rm_rf(path) if File.exist?(path)
    FileUtils.rm_rf File.join( 'public', File.dirname(wrl) )
  end

  def self.recommend
    first 
  end

  def wrl
    available ? "/papers/part_#{id}/3d.wrl" : '/rose.wrl'
  end

  def jpg
    available ? "/papers/part_#{id}/preview.jpg" : '/images/preview.jpg'
  end

  def jpgs

  end

  def preprocess
    JobsQueue.instance.add('preprocess_part', id)
    logger.info '#' * 40
    logger.info Time.now.strftime 'Time: %m/%d/%y - %I:%M:%S %p'
    logger.info "Add a new job: preprocess_part => #{id}"
    logger.info '#' * 40 + "\n"
  end

  def change(params = {})
    params.merge!('id' => id)
    JobsQueue.instance.add('change_part', params)
    logger.info '#' * 40
    logger.info Time.now.strftime 'Time: %m/%d/%y - %I:%M:%S %p'
    logger.info "Add a new job: change_part => #{id}"
    logger.info '#' * 40 + "\n"
  end
end
