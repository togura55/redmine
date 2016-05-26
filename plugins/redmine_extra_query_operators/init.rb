require 'redmine'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3
require 'eqo_asset_helpers'

unless Redmine::Plugin.registered_plugins.keys.include?(EQO_AssetHelpers::PLUGIN_NAME)
  Redmine::Plugin.register EQO_AssetHelpers::PLUGIN_NAME do
    name 'Extra query operators plugin'
    author 'Vitaly Klimov'
    author_url 'mailto:vitaly.klimov@snowbirdgames.com'
    description 'Adds extra operators to issues query, allowing to select exact dates and offsets from current date. Also this plugin adds ability to use regular expressions in text fields'
    version '1.1.2'

    requires_redmine :version_or_higher => '1.3.0'
  end
end

if Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    require 'extra_query_operators_patch'
  end
else
  Dispatcher.to_prepare EQO_AssetHelpers::PLUGIN_NAME do
    require_dependency 'extra_query_operators_patch'
  end
end
