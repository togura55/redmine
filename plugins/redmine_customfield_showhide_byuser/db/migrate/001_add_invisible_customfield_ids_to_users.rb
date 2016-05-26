class AddInvisibleCustomfieldIdsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invisible_customfield_ids, :text
  end

  def self.down
    remove_column :users, :invisible_customfield_ids
  end
end
