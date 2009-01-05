require 'ftools'
require 'mini_magick' 

class Part < Paper
  has_many :taggings, :as => :taggable, :dependent => :delete_all
  has_many :tags, :through => :taggings

  has_many :parameters, :foreign_key => 'paper_id', :dependent => :destroy

  after_create :write_file, :preprocess 
  after_destroy :delete_file

  validates_format_of :filename, :with => /^.+\.SLDPRT$/i, :on => :create, 
    :message => 'Only Accept SolidWork\'s Part Drawing Currently'
  validates_inclusion_of :size, :in => 1.kilobyte..5.megabytes, :on => :create,
    :message => 'Only Accept File Size Between 1KB and 5MB'
  validates_presence_of :desc

  def find_by_tags(tag_names)
    # TODO
    # 'aaa bbb ccc'
    # cache the results
  end

  def tag_list
    reload(:select => :id)
    self.tags.collect(&:name)
  end

  def tag_summary
    tag_list.sort.join(', ')
  end

  def tag_summary=(tag_names)
    self.taggings = []
    Tag.sanitize_name(tag_names).each do |e|
      self.tags << Tag.find_or_create_by_name(e) 
    end
  end

  def add_tags(tag_names)
    Tag.sanitize_name(tag_names).each do |e|
      self.tags << Tag.find_or_create_by_name(e) unless tag_list.include?(e) 
    end
  end

  def remove_tag(tag_id)
    tagging = taggings.find_by_tag_id(tag_id)
    tagging.delete if tagging
  end

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
    %W(
      /papers/part_#{id}/top.jpg
      /papers/part_#{id}/front.jpg
      /papers/part_#{id}/left.jpg
      /papers/part_#{id}/isometric.jpg
    )
  end

  def gen_thumbnail
    img_file = File.join( 'public', 
                          File.dirname(self.jpg),
                          'isometric.jpg' ) 

    img = MiniMagick::Image.from_file(img_file)

    w, h = img[:width], img[:height]
    l, t, half = 0, 0, (w - h).abs / 2
    if w > h then l, s = half, h else  t, s = half, w end

    thumbnail = File.join(File.dirname(img_file), 'preview.jpg') 

    img.crop("#{s}x#{s}+#{l}+#{t}").scale(140).write(thumbnail)
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
