class MigrateFreebugidCustomFields < ActiveRecord::Migration

    def self.up
        if CustomField.column_names.include?('format_store')
            CustomField.where(:field_format => 'freebugid').update_all(:field_format => 'text',
                                                                  :format_store => { :text_formatting => 'full'}.to_yaml)
        end
    end

end
