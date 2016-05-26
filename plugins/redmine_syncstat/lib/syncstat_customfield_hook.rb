class SyncstatCustomfieldHook < Redmine::Hook::ViewListener

  # Display the additional field on the new custom field page 
  #  by using hook which has been provided by Redmine
  #
  # Context
  # * :custom_field => the custom field
  # * :form => form shown in the upper box
  #
  def view_custom_fields_form_upper_box(context = { })
      context[:controller].send(:render_to_string, {
        :partial => "view_custom_fields_form_upper_box_syncstat_patch", # app\views\custom_fields
        :locals => { :f => context[:form] }   # refered f in the patch
      })

  end

end
