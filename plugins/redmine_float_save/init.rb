require 'redmine'
require 'float_save_issues_hook'

Redmine::Plugin.register :redmine_float_save do
  name 'Float Save plugin'
  author 'togura'
  description 'Enable users displaying a pop-up window with Save buttons'
  version '1.0.5'
end
