require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archive do
  before(:each) do
    @archive = Archive.new
    @archive.upload_file = fixture_file_upload('/../fixtures/bucket.zip',
                                                'application/x-zip-compressed') 
  end

  it 'should accept zip formate file' do
    @archive.valid?
    @archive.errors[:base].should be_nil
  end

  it 'should not accept other file format to attach' do
    @invalid_file = flexmock( :invalid_file,
                              :content_type      => 'text/javascript',
                              :original_filename => 'Invalide File',
                              :size              => 0)
    @archive.upload_file = @invalid_file
    @archive.valid?
    @archive.errors[:base].should include 'Only Accept ZIP Archives'
  end

  it 'should write the attach file after save' do
    @archive.save
    File.exist?(@archive.file_path).should be_true
  end

  it 'should unzip the attachment' do
    @archive.save
    Dir.entries(File.join(@archive.upload_path, 'tmp')).size.should eql(5)
    @archive.destroy
  end

  after :each do
    @archive.destroy
  end
end
