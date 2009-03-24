class ExtendUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :primary_cad, :string
    add_column :users, :company_name, :string
    add_column :users, :nation, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :zipcode, :string
    add_column :users, :phone, :string
    add_column :users, :fax, :string
    add_column :users, :website, :string
  end

  def self.down
    remove_column :users,   :website,      :fax,  :phone,
                  :zipcode, :address,      :city, :province,
                  :nation,  :company_name, :primary_cad
  end
end
