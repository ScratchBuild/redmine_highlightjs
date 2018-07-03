require 'redmine'
require 'code_theme_my_account_hooks'
require 'code_theme_user_patch'
require 'code_theme_themes_patch'

require_dependency 'hooks/view_highlighted_hook'

Redmine::Plugin.register :redmine_highlightjs do
  name 'Syntax highlighting with highlightjs'
  author 'Dominik Chmaj'
  url 'https://github.com/dominch/redmine_highlightjs'
  author_url 'http://dominik.net.pl/'
  description 'Adds much better syntax highlighting with autodetection'
  version '1.0.4'
  settings default: { 'theme' => 'monokai_sublime' }, partial: 'settings/highlightjs_settings'
  requires_redmine version_or_higher: '3.0.0'
end

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'highlightjs_highlighting'
end

Rails.configuration.to_prepare do
  require_dependency 'user_preference'
  UserPreference.send(:include, CodeThemeUserPreferencePatch) unless UserPreference.included_modules.include? CodeThemeUserPreferencePatch
end
