require 'redmine'
#require 'dispatcher'

require 'openedby_date_issue_patch'


ActionDispatch::Callbacks.to_prepare do
  require_dependency 'project'
  require_dependency 'issue'
  Issue.send(:include, OpenedbymeOpeneddateIssuePatch)
end

Redmine::Plugin.register :redmine_autofill_user_date do
  name 'Auto-fill Username and Date plugin'
  author 'tbojo'
  description 'Auto-fill in custom fields of Opened-By / Opened Date / Checked by / Date by appropriate values.'
  version '1.0.5'

#  settings :default => {'default_assignee_id' => nil}, :partial => 'settings/default_assign'

end
