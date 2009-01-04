class ActsAsTaggableMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.timestamp
    end
    
    create_table :taggings do |t|
      t.integer :tag_id, :taggable_id
      t.string :taggable_type
      t.timestamp
    end
    
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]
    add_index :taggings, [:tag_id, :taggable_id, :taggable_type], :unique => true
  end
  
  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
