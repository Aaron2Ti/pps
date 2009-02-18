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
  validates_presence_of :name

  def self.search(keywords)
     results = Tag.sanitize_name(keywords).collect do |keyword|
       find_by_keyword(keyword)
     end
     results << find_by_tags(keywords)
     results.flatten.uniq
  end

  def self.find_by_keyword(keyword)
    all(:conditions => ['name like ?', "%#{keyword}%"])
  end

  # 'aaa bbb ccc'
  def self.find_by_tags(tag_names)
    taggings = Tag.sanitize_name(tag_names).collect do |name|
                 tag = Tag.find_by_name(name, :select => [:id], :include => [:taggings])
                 tag.taggings.all(:conditions => {:taggable_type => 'Paper'}) if tag
               end.flatten

    ids = taggings.collect{ |tagging| tagging.taggable_id }.uniq unless taggings.empty?

    find(ids) if ids
  end

  def tag_list
    reload(:select => :id)
    self.tags.collect(&:name)
  end

  def tag_summary
    tag_list.sort.join(', ')
  end

  def tag_summary=(tag_names)
    old_tags = self.taggings.collect(&:tag_id)
    new_tags = Tag.sanitize_name(tag_names).collect{ |e| Tag.find_or_create_by_name(e).id }

    self.taggings.all( :conditions => {:tag_id => (old_tags - new_tags)} ).
                  each(&:delete) unless (old_tags - new_tags).empty?
    (new_tags - old_tags).each do |tag_id|
      self.taggings << Tagging.new(:tag_id => tag_id)
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
    FileUtils.rm_r(path) if File.exist?(path)
    FileUtils.rm_r File.join( 'public', "papers/part_#{id}" )
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
      /papers/part_#{id}/isometric.jpg
      /papers/part_#{id}/top.jpg
      /papers/part_#{id}/front.jpg
      /papers/part_#{id}/left.jpg
    )
  end

  def gen_thumbnail
    img_file = File.join( 'public', "papers/part_#{id}", 'isometric.jpg' )

    img = MiniMagick::Image.from_file(img_file)

    w, h = img[:width], img[:height]
    l, t, half = 0, 0, (w - h).abs / 2
    if w > h then l, s = half, h else  t, s = half, w end

    thumbnail = File.join(File.dirname(img_file), 'preview.jpg')

    # #{width}x#{heiht}+#{left}+#{top}
    img.crop("#{s}x#{s}+#{l}+#{t}").scale(140).write(thumbnail)
  end

  def preprocess
    # Marchal and Inflate the part
    part = Marshal.dump({ :id => id,
                          :filename => filename,
                          :process_type => 'preprocess' })
    JobsQueue.instance.add('process_drawing', part)
  end

  def change(params = {})
    params = params.collect do |k, v|
      [Parameter.find(k).def, v.to_f]
    end
    part = Marshal.dump({ :id => id,
                          :filename => filename,
                          :params => params.to_a,
                          :process_type => 'change' })
    JobsQueue.instance.add('process_drawing', part)
  end

  def published?
    published
  end
end
