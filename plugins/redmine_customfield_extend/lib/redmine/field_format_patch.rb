require_dependency 'redmine/field_format'

module Redmine
  module FieldFormatPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
      alias_method_chain :edit_tag, :my_edit_tag
	  end
    end
	module InstanceMethods
      def edit_tag_with_my_edit_tag(view, tag_id, tag_name, custom_value, options={})
		base_width = 90	
		case custom_value.custom_field.id.to_i
		when 70 #Descriptions
         edit_row = 30
		when 110 #Environment
		 edit_row = 50
		else
		 edit_row =3
		end
        width_rate = sprintf("width:%d%",base_width)
        view.text_area_tag(tag_name, custom_value.value, options.merge(:id => tag_id, :rows => edit_row, :style => width_rate))
      end
    end
	
	end
end
# Add module to CustomFieldHelper
Redmine::FieldFormat::TextFormat.send(:include, Redmine::FieldFormatPatch)