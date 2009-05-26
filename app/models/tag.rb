# encoding: utf-8
class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :delete_all

  def parts
    taggings.map{|tagging| Part.find(tagging.taggable_id)}
  end

  class << self
    def sanitize_name(tag_names)
      tag_names.gsub(/　|——|。|｜|（|）|《|》|！|：|￥/, ''). # delete unwanted charaters
      gsub(/，|、| /, ','). # replace seperators with comma
      split(',').collect(&:strip).delete_if{|e| e == ''}.uniq
    end
  end

end
