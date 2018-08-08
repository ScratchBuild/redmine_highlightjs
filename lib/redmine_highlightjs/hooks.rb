module RedmineHighlightjs
  class RedmineHighlightjsHookListener < Redmine::Hook::ViewListener
    render_on :view_my_account, partial: 'settings/code_theme_form', multipart: true

    def view_layouts_base_html_head(_context = {})
      begin
        Redmine::SyntaxHighlighting.highlighter = 'HighlightJs'
      rescue StandardError => e
        Rails.logger.info "redmine_highlightjs2: cannot turn off CodeRay. Error: #{e.message}"
      end

      RedmineHighlightjs.settings[:allow_redefine] && User.current.preference.present? && theme = User.current.preference.code_theme

      theme = RedmineHighlightjs.settings[:theme] if theme.blank? || theme == CodeThemeUserSetting::DEFAULT_CODE_THEME
      theme = 'monokai-sublime' if theme.blank?

      stylesheet_link_tag("themes/#{theme}.css", plugin: 'redmine_highlightjs', media: 'screen') +
        stylesheet_link_tag('fixes.css', plugin: 'redmine_highlightjs', media: 'screen') +
        javascript_include_tag('highlight.pack.min.js', plugin: 'redmine_highlightjs') +
        javascript_include_tag('loader.js', plugin: 'redmine_highlightjs')
    end
  end
end
