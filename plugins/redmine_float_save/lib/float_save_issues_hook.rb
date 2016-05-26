# To change this template, choose Tools | Templates
# and open the template in the editor.

class FloatsaveIssueHooks < Redmine::Hook::ViewListener
  def view_issues_form_details_top(context={})

    @this_issue = context[:issue]
 #   @params = context[:params]
    
    # Custom Field name to be read
    cf_name = 'enable_floatsave'
    cf = CustomField.find_by_name(cf_name)
#    cv = CustomValue.find_all_by_customized_type_and_custom_field_id('Principal', cf.id) if cf
    cv = CustomValue.where(["customized_type = ? and custom_field_id = ?", 'Principal', cf.id] ) if cf

    @user = User.current 
    $floatsave = false
    result = cv.detect{|c| c.customized_id == @user.id and c.value == '1'} if cv
    $floatsave = true if result

    # ViewListener requires output HTML. 
    # Following code avoids to display unexpected strings on UI
    html = ''

#    context[:controller].send(:render,
#      {:partial => "issues/float_save.html"
#    })
    
  end
end
