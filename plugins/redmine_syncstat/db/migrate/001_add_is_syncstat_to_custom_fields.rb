class AddIsSyncstatToCustomFields < ActiveRecord::Migration
  def self.up
    add_column :custom_fields, :is_syncstat, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :custom_fields, :is_syncstat
  end
end
