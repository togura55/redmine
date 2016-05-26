class AddColorCustomfieldIdToCustomFields < ActiveRecord::Migration
  def self.up
    add_column :custom_fields, :color_customfield_id, :integer
  end

  def self.down
    remove_column :custom_fields, :color_customfield_id
  end
end
