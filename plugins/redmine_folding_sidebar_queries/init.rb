require 'redmine'

require_dependency 'folding_sidebar_queries_hook'

Redmine::Plugin.register :redmine_folding_sidebar_queries do
  name 'Folding Sidebar Queries Menu (Redmine plugin)'
  author 'Brian Fujito'
  description 'This provides a folding menu (initially auto-folded) for the list of queries in Redmine, in the right sidebar.  Sorry, it is hacky, but works!'
  version '1.0.2'
end
