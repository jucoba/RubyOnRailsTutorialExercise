class AddColumnChurchNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :churchname, :string 
  end

  def down
    remove_column :users, :churchname, :string
  end

end
