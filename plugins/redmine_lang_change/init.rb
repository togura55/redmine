require 'redmine'

Redmine::Plugin.register :redmine_lang_change do
  name 'Change Language Strings plugin'
  author 'tsato'
  description 'Display particular UI strings by pre-defined language.'
  version '1.0.4'
  url 'http://example.com/path/to/plugin' if respond_to?(:url)
  author_url 'http://example.com/about' if respond_to?(:url)

end