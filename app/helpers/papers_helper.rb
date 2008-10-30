module PapersHelper
  def assembles
    @paper.archive.assembles.collect{|c| [c.filename, c.id]} << [ 'null', nil ]
  end
end
