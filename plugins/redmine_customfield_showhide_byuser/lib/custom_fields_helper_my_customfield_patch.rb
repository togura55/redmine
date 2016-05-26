require_dependency 'custom_fields_helper'

# Patches Redmine's custom_fields_helper dynamically. 
# 
module CustomFieldsHelperMyCustomfieldPatch
  def self.included(base) # :nodoc:
#    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    # Same as typing in the class
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :custom_field_tag_with_label, :my_customfield_tag_with_label

    end
  end

  module ClassMethods
  end

	module InstanceMethods
		def custom_field_tag_with_label_with_my_customfield_tag_with_label(name, custom_value)
			begin
                		# load invisible custom_field id converted to int
				invisible_list = nil
				invisible_list = User.current.invisible_customfield_ids.rstrip.split(/\r?\n/).map {|x| x.chomp.to_i } 
				if !invisible_list.include? custom_value.custom_field.id.to_i then
					custom_field_label_tag(name, custom_value) + custom_field_tag(name, custom_value)
				end

			rescue
				custom_field_label_tag(name, custom_value) + custom_field_tag(name, custom_value)
			end

		end
	end

end

# Add module to CustomFieldHelper
CustomFieldsHelper.send(:include, CustomFieldsHelperMyCustomfieldPatch)

