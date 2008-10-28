require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paper do
  before(:each) do
    @archive = Archive.new
    flexmock(@archive, {:id => 1})
    @paper = Paper.new(:filename => 'test.sldprt',
                      :path => 'tmp')
  end

  it do

  end
end
