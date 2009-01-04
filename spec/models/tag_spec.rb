require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do
  it do
    tag_name = Tag.sanitize_name( ',，,,,,中国，　，。+《》　 asdf asdf , a、b,b')
    tag_name.should eql ['中国', '+', 'asdf', 'a', 'b']
  end
end
