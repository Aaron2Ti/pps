require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paper do
  before(:each) do
    @archive = Archive.new
    flexmock(@archive, {:path => 'uploads/archive_20'})
    @paper = Paper.new(:filename => 'test.sldprt',
                       :archive  => @archive)
  end

  it 'should be in archive\'s sub-directorys' do
    @paper.path.should eql 'uploads/archive_20/tmp'
  end

  it do
     @paper.file_path.should eql 'uploads/archive_20/tmp/test.sldprt'
  end
end
