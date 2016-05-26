class IssueHooks < Redmine::Hook::ViewListener 
#  def view_issues_show_description_bottom(context)
#	  render "redmine_child_link_to"
	#	  
#  end
##aditiona codes for count  
# read/store tracker flags to global valuables 



	render_on :view_issues_show_description_bottom, :partial => "issues/redmine_child_link_to" 

end
