class AddIsHideQarepdbcToTrackers < ActiveRecord::Migration
  def self.up
    add_column :trackers, :is_hide_qarepdbc, :boolean, :default => false, :null => false
    add_column :trackers, :is_hide_environment, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :trackers, :is_hide_qarepdbc
    remove_column :trackers, :is_hide_environment
  end
end
