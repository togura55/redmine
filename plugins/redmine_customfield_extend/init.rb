require 'redmine'
#require 'custom_fields_helper_patch_extend'
require 'redmine/field_format_patch'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'project'
  require_dependency 'issue'
end

Redmine::Plugin.register :redmine_customfield_extend do
  name 'Redmine Customfield extend plugin'
  author 'tsato'
  description 'Enlarge the number of lines for custom field'
  version '1.0.2'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

end
