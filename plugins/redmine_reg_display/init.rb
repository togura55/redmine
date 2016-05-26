require 'redmine'
# require 'isssues_helper_patch'

Redmine::Plugin.register :redmine_reg_display do
  name 'Add Regresssion Ticket'
  author 'togura'
  description 'Display a link of create Add Regresison Ticket on the issues page'
  version '1.0.2'
#  url 'http://tolinux01.global.sdl.corp/redmine01/projects/blanco/wiki/RedminePlugins' if respond_to?(:url)
#  author_url 'http://tolinux01.global.sdl.corp/redmine01/projects/blanco/wiki' if respond_to?(:url)

#  project_module :redmine_reg_display do
#    permission :color_customfield, :public => true
#  end
end