require 'redmine'

require 'custom_fields_helper_my_customfield_patch'

Redmine::Plugin.register :redmine_customfield_showhide_byuser do
  name 'Redmine Show/Hide Customfield plugin'
  author 'tbojo'
  description 'Configure the visible/invisible Custom Field by personel. External tool "ShowHideCustomFields" is in use.'
  version '1.0.2'

#  project_module :my_customfield do
#    permission :my_customfield, :public => true
#  end

end
