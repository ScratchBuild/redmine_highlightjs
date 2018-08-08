require_dependency 'redmine_highlightjs'

Redmine::Plugin.register :redmine_highlightjs do
  name 'Syntax highlighting with highlightjs'
  author 'Dominik Chmaj'
  url 'https://github.com/dominch/redmine_highlightjs'
  author_url 'http://dominik.net.pl/'
  description 'Adds much better syntax highlighting with autodetection'
  version '1.0.4'
  settings default: { 'theme' => 'monokai-sublime' }, partial: 'settings/highlightjs_settings'
  requires_redmine version_or_higher: '3.4.0'
end

if ActiveRecord::Base.connection.table_exists?(:settings)
  Rails.configuration.to_prepare do
    RedmineHighlightjs.setup
  end
end
