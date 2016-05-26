require 'redmine'
# require 'dispatcher'

require 'syncstat_customfield_hook'
require 'syncstat_issue_patch'
# Dispatcher.to_prepare do
ActionDispatch::Callbacks.to_prepare do
  require_dependency 'project'
  require_dependency 'issue'
  Issue.send(:include, SyncstatIssuePatch)
end

Redmine::Plugin.register :redmine_syncstat do
  name 'SyncStat plugin'
  author 'togura'
  description 'Syncronize Status Value from Child Issues to Parent s'
  version '1.0.3'
  url 'http://collaboration.sdl.com/Corporate/offices/tokyo/Engineering/Tools_Project/QARepDB/default.aspx'
#  author_url 'http://example.com/about'


end
