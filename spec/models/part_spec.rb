require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Part do
  before(:each) do
    @part = Part.new
    flexmock(@part, :id => 1)
  end

  it 'should have tag_list and tag_summary' do
    @part.tags << Tag.new(:name => 'Foo') << Tag.new(:name => 'Bar')
    @part.tag_list.should eql ['Foo', 'Bar']
    @part.tag_summary.should eql 'Foo, Bar'
  end

  it 'should add a new tag by name' do
    @part.add_tag 'Foo'
    @part.tag_list.should eql ['Foo']
    @part.add_tag 'Bar'
    @part.tag_list.should eql ['Foo', 'Bar']
    @part.add_tag 'Bar'
    @part.tag_list.should eql ['Foo', 'Bar']
  end

  it 'should add lots tags by name' do
    @part.add_tags 'Foo,Bar'
    @part.tag_list.should eql ['Foo', 'Bar']
    @part.add_tags 'Cool,Bar'
    @part.tag_list.should eql ['Foo', 'Bar', 'Cool']
  end


  it 'should remove tag by name' do
    @part.tag_list = ['Foo', 'Bar']
    @part.remove_tag 'Foo'
    @part.tag_list.should eql ['Bar']
  end

  it 'should initialize its tag_list' do
    @part.tag_list = ['Foo', 'Bar']
    @part.tag_list.should eql ['Foo', 'Bar']
    @part.tag_list = ['foo', 'bar']
    @part.tag_list.should eql ['foo', 'bar']
  end

  after :each do
    @part.tags.delete_all
  end



#  it 'could add and remove tags' do
#    @part.add_tag 'Big', 'Apple'
#    @part.tag_list.should include 'Big', 'Apple'
#    @part.remove_tag 'Apple'
#    @part.tag_list.should_not include 'Apple'
#  end

#  it 'should have tag_summary' do
#    @part.add_tags ' 　《》￥中国，好事 、篮球 '
#    @part.tag_list.should include '好事', '篮球', '中国'

#    @part.remove_tag '       Big'
#    @part.tag_list.should_not include 'Big'
#    @part.tag_summary = ' 　《》￥中国，好事 、篮球 '
#    @part.should have(3).tag_list
#  end
end
