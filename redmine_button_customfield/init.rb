require 'redmine'
require 'dispatcher'

require 'button_customfield_custom_fields_helper_patch'
require 'button_customfield_customfield_hook'
require 'button_customfield_issue_patch'
require 'button_customfield_issues_controller_patch'

Dispatcher.to_prepare do
  require_dependency 'project'
  require_dependency 'issue'
  Issue.send(:include, ButtonCustomfieldIssuePatch)
#  IssuesController.send(:include, ButtonCustomfieldIssuesControllerPatch)
end


Redmine::Plugin.register :redmine_button_customfield do
  name 'Redmine Button Customfield plugin'
  author 'Tsuyoshi Ogura'
  description 'This is a plugin for Redmine enabling button action on the custom field'
  version '0.0.2'
  url 'http://tolinux01.global.sdl.corp/redmine01'
  author_url 'http://tolinux01.global.sdl.corp/redmine01'

  project_module :button_customfield do
    permission :button_customfield_status, :public => false
  end

end
