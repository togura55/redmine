require 'redmine'

require 'custom_fields_helper_patch'
require_dependency 'color_customfield_customfield_hook'
require 'color_customfield_common'

Redmine::Plugin.register :redmine_color_customfield do
  name 'Redmine Color Customfield plugin'
  author 'togura'
  description 'Put the color text to custome field name'
  version '1.0.3'

  project_module :color_customfield do
    permission :color_customfield, :public => true
  end
end