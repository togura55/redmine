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

      alias_method_chain :custom_field_label_tag, :color_customfield_label_tag

    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def custom_field_label_tag_with_color_customfield_label_tag(name, custom_value, options={})

      if custom_value.custom_field.color_customfield_id == 1 then
         color = "<span class=\"color_customfield_blue\">" + h(custom_value.custom_field.name) + "</span>"
      elsif custom_value.custom_field.color_customfield_id == 2 then
         color = "<span class=\"color_customfield_green\">" + h(custom_value.custom_field.name) + "</span>"
      elsif custom_value.custom_field.color_customfield_id == 3 then
         color = "<span class=\"color_customfield_yellow\">" + h(custom_value.custom_field.name) + "</span>"
      elsif custom_value.custom_field.color_customfield_id == 4 then
         color = "<span class=\"color_customfield_pink\">" + h(custom_value.custom_field.name) + "</span>"
      elsif custom_value.custom_field.color_customfield_id == 5 then
         color = "<span class=\"color_customfield_orange\">" + h(custom_value.custom_field.name) + "</span>"
      else
         color = h(custom_value.custom_field.name)
      end
    
      content_tag "label", color.html_safe +
 	(custom_value.custom_field.is_required? ? " <span class=\"required\">*</span>".html_safe : ""),
	:for => "#{name}_custom_field_values_#{custom_value.custom_field.id}" #,  ##comment out "," for 1.4 (bug#8116)
	# :class => (custom_value.errors.empty? ? nil : "error" ) ##comment out this line for 1.4 (bug#8116)
    end
  end
end

# Add module to CustomFieldHelper
CustomFieldsHelper.send(:include, CustomFieldsHelperPatch)

