require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Archive do
  before(:each) do
    @archive = Archive.new

    @upload_file = flexmock('upload_file',
                            :original_filename => 'bucket.zip',
                            :content_type      => 'application/x-zip-compressed',
                            :size              => 20)
    @archive.upload_file = @upload_file
#       fixture_file_upload('/../fixtures/bucket.zip',
#                                                 'application/x-zip-compressed') 
  end

  it 'should have same filename with the upload file' do
    @archive.filename.should eql 'bucket.zip'
  end

  it '\'s filepath should be uploads/archive_id'

  it 'should delete all the descendent files' do
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
    @archive.should have(1).error_on :base
  end

end


describe Archive, 'unzip, save and destroy' do
  before :each do
    @archive = Archive.new
    @archive.upload_file = fixture_file_upload('/../fixtures/bucket.zip',
                                                'application/x-zip-compressed') 
    @archive.save
  end

  it 'should delet descendent file after destroy' do
    @archive.destroy
    File.exist?(@archive.file_path).should be_false
  end

  it 'should write the attach file and  unzip it after save' do
    File.exist?(@archive.file_path).should be_true
    Dir.new(File.join(@archive.upload_path, 'tmp')).should have(5).entries
  end

  after :each do
    @archive.destroy
  end

end
