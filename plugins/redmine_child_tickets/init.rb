require 'redmine'
#require 'dispatcher'
require 'issue_hooks'
require 'issues_controller_patch'

ActionDispatch::Callbacks.to_prepare do 
  require_dependency 'project'
  require_dependency 'issue'
  IssuesController.send(:include, IssuesControllerPatch)
end

if ActiveRecord::Base.connection.column_exists? :trackers, :is_childticket_qarepdbc then
trackers_qarepdbc = Tracker.where(is_childticket_qarepdbc: true)
#trackers_environment = Tracker.where(is_childticket_environment: true)

$childticket_qarepdbc = []
#$childticket_environment = []
trackers_qarepdbc.each do |t|
  $childticket_qarepdbc << t.id
end
end

Redmine::Plugin.register :redmine_child_tickets do
  name 'redmine_ child_ticket'
  author 'tsato'
  description 'Create a ticket for regression. Change the tracker to Bug Regression when copy button was pressed'
  version '1.3'

#  project_module :importer do
#    permission :import, :importer => :index
#  end
#  menu :project_menu, :importer, { :controller => 'importer', :action => 'index' }, :caption => :label_import, :before => :settings, :param => :project_id
end



