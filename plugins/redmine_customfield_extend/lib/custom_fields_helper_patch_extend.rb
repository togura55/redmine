require_dependency 'custom_fields_helper'

# Patches Redmine's custom_fields_helper dynamically. 
# 
module CustomFieldsHelperPatch
  def self.included(base) # :nodoc:
#    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

#      alias_method_chain :custom_field_label_tag, :color_customfield_label_tag
      alias_method_chain :custom_field_tag, :resize_tag

    end
  end

  module ClassMethods
  end

  module InstanceMethods

#
# Resize
#
   def custom_field_tag_with_resize_tag(name, custom_value)

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

    custom_field = custom_value.custom_field
    field_name = "#{name}[custom_field_values][#{custom_field.id}]"
    field_id = "#{name}_custom_field_values_#{custom_field.id}"

    field_format = Redmine::CustomFieldFormat.find_by_name(custom_field.field_format)
    case field_format.try(:edit_as)
    when "date"
      text_field_tag(field_name, custom_value.value, :id => field_id, :size => 10) +
      calendar_for(field_id)
    when "text"
      text_area_tag(field_name, custom_value.value, :id => field_id, :rows => edit_row, :style => width_rate)
    when "bool"
      hidden_field_tag(field_name, '0') + check_box_tag(field_name, '1', custom_value.true?, :id => field_id)
    when "list"
      blank_option = custom_field.is_required? ?
                       (custom_field.default_value.blank? ? "<option value=\"\">--- #{l(:actionview_instancetag_blank_option)} ---</option>" : '') :
                       '<option></option>'
      select_tag(field_name, blank_option + options_for_select(custom_field.possible_values_options(custom_value.customized), custom_value.value), :id => field_id)
    else
      text_field_tag(field_name, custom_value.value, :id => field_id)
    end
  end

 end

end

# Add module to CustomFieldHelper
CustomFieldsHelper.send(:include, CustomFieldsHelperPatch)

