class ColorCustomfieldCustomfieldHook < Redmine::Hook::ViewListener

  # Saves the Color Customfield into a new custom_field
  #
  # Context
  # * :params => params passed back by the form
  # * :custom_field => the new custom_field
  #
  def controller_custom_fields_new_after_save(context = { })
    if context[:params][:custom_field][:color_customfield_id] =~ /(\d+)/ then
      color_customfield_id = context[:params][:custom_field][:color_customfield_id].to_i
      context[:custom_field].color_customfield_id = 100 # ToDo...
    end

    return ''
  end

  # Saves the Color Customfield when an custom_field is updated
  #
  # Context
  # * :params => params passed back from the form
  # * :custom_field => the custom_field
  def controller_custom_fields_edit_after_save(context = { })
    if context[:params][:custom_field][:color_customfield_id] then
      color_customfield_id = context[:params][:custom_field][:color_customfield_id]
      unless color_customfield_id == ''
        context[:custom_field].color_customfield_id = 100 # ToDo...
      end
    end

    return ''
  end

  # Saves the Color Customfield when issues are updated via bulk_edit
  #
  # Context
  # * :params => params passed back from the form
  # * :custom_field => the custom_field
#  def controller_issues_bulk_edit_before_save(context = { })
#    color_customfield_id = context[:params][:color_customfield_id]
#
#    if color_customfield_id.blank? then
#      # Do nothing
#    elsif context[:params][:color_customfield_id] =~ /(\d+)/ then
#      context[:custom_field].color_customfield = 100 # ToDo.....
#    end
#
#    return ''
#  end

  # Display the additional field on new custom field page by using hook
  #
  # Context
  # * :custom_field => the custom field
  # * :form => form shown in the upper box
  #
  def view_custom_fields_form_upper_box(context = { })
      context[:controller].send(:render_to_string, {
        :partial => "view_custom_fields_form_upper_box_patch", # app\views\custom_fields
        :locals => { :f => context[:form] }   # refered f in the patch
      })

  end


  #
  # Using hook for adding something into the HTML header across the Redmine
  #  Include color_customfield.css to the default stylesheet
  #
  def view_layouts_base_html_head(context={})
    stylesheet_link_tag 'color_customfield', :plugin => 'redmine_color_customfield'
  end

end
