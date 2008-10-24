class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.integer 'archive_id', 'assemble_id'
      t.string 'filename', 'desc', 'type'
    end
  end

  def self.down
    drop_table :papers
  end
end
