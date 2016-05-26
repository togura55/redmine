class AddIsChildticketQarepdbcToTrackers < ActiveRecord::Migration
  def self.up
    add_column :trackers, :is_childticket_qarepdbc, :boolean, :default => false, :null => false
    add_column :trackers, :is_childticket_environment, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :trackers, :is_childticket_qarepdbc
    remove_column :trackers, :is_childticket_environment
  end
end
