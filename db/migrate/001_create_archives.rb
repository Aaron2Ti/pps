class CreateArchives < ActiveRecord::Migration
  def self.up
    create_table :archives do |t|
      t.string 'desc', 'filename', 'content_type'
      t.integer 'size'
    end
  end

  def self.down
    drop_table :archives
  end
end
