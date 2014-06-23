require_dependency 'custom_fields_helper'

# Patches Redmine's custom_fields_helper dynamically. 
# 
module ButtonCustomfieldCustomFieldsHelperPatch
  def self.included(base) # :nodoc:
#    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :custom_field_tag_with_label, :button_customfield

    end
  end

  module ClassMethods
  end



  module InstanceMethods

#    def custom_field_button(name, custom_value)
#        return button_to(I18n.t('button_customfield_label'))
#    end

    def kakunin
    end

    def custom_field_tag_with_label_with_button_customfield(name, custom_value)

        button = ''
        
#	custom_field = CustomField.find_by_id(cfv.custom_field_id)

        if custom_value.custom_field.is_button_customfield then
#           button = button_to(I18n.t('button_customfield_label'), :controller => 'issues', :action => 'button')
           button = submit_tag(I18n.t('button_customfield_label'), :controller => 'issues', :action => 'button')
	end
	
	custom_field_label_tag(name, custom_value) + custom_field_tag(name, custom_value) +  button 


#      if custom_value.custom_field.color_customfield_id == 1 then
#         color = "<span class=\"color_customfield_blue\">" + h(custom_value.custom_field.name) + "</span>"
#      elsif custom_value.custom_field.color_customfield_id == 2 then
#         color = "<span class=\"color_customfield_green\">" + h(custom_value.custom_field.name) + "</span>"
#      elsif custom_value.custom_field.color_customfield_id == 3 then
#         color = "<span class=\"color_customfield_yellow\">" + h(custom_value.custom_field.name) + "</span>"
#      elsif custom_value.custom_field.color_customfield_id == 4 then
#         color = "<span class=\"color_customfield_pink\">" + h(custom_value.custom_field.name) + "</span>"
#      elsif custom_value.custom_field.color_customfield_id == 5 then
#         color = "<span class=\"color_customfield_orange\">" + h(custom_value.custom_field.name) + "</span>"
#      else
#         color = h(custom_value.custom_field.name)
#      end
    
#      content_tag "label", color +
# 	(custom_value.custom_field.is_required? ? " <span class=\"required\">*</span>".html_safe : ""),
#	:for => "#{name}_custom_field_values_#{custom_value.custom_field.id}" #,
    end
  end

end

# Add module to CustomFieldHelper
CustomFieldsHelper.send(:include, ButtonCustomfieldCustomFieldsHelperPatch)

