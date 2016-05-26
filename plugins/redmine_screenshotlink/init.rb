require 'redmine'
#require 'dispatcher'

require 'screenshotlink_issue_patch'


ActionDispatch::Callbacks.to_prepare do 
  require_dependency 'project'
  require_dependency 'issue'
  Issue.send(:include, ScreenshotlinkIssuePatch)
end

Redmine::Plugin.register :redmine_screenshotlink do
  name 'Screenshot Link plugin'
  author 'tbojo'
  description 'Auto-fill Current Screenshot field'
  version '1.0.3'

#  settings :default => {'default_assignee_id' => nil}, :partial => 'settings/default_assign'

end
