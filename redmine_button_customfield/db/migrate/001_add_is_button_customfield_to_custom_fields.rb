class AddIsButtonCustomfieldToCustomFields < ActiveRecord::Migration
  def self.up
    add_column :custom_fields, :is_button_customfield, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :custom_fields, :is_button_customfield
  end
end
