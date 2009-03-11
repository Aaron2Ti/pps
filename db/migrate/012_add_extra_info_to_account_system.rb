class AddExtraInfoToAccountSystem < ActiveRecord::Migration
  def self.up
    add_column :users,    :name,     :string
    add_column :users,    :email,    :string
    add_column :users,    :title,    :string
    add_column :users,    :company,  :string
    add_column :users,    :avatar,   :string
    add_column :users,    :type,     :string
    add_column :papers,   :owner_id, :integer
    add_column :taggings, :owner_id, :integer
  end

  def self.down
    remove_column :papers,   :owner_id
    remove_column :taggings, :owner_id
    remove_column :users,    :avatar
    remove_column :users,    :type
    remove_column :users,    :company
    remove_column :users,    :title
    remove_column :users,    :email
    remove_column :users,    :name
  end
end
