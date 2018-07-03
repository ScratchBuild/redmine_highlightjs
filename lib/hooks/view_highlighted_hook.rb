module Highlightjs
  module Hooks
    class HighlightjsHookListenerHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context = {})
        request = context[:request].env['HTTP_USER_AGENT']
        user_agent = UserAgent.parse(request)

        if SUPPORTED_BROWSERS.detect { |browser| user_agent >= browser }
          Rails.logger.info "redmine_highlightjs2: supported browser: #{user_agent}"
          begin
            Redmine::SyntaxHighlighting.highlighter = 'HighlightJsSyntaxHighlighting'
          rescue
            Rails.logger.info 'redmine_highlightjs2: cannot turn off CodeRay'
          end

          theme = if HighlightJsSyntaxHighlighting.settings[:allow_redefine] && User.current.preference.present?
                    User.current.preference.code_theme
                  end

          theme = HighlightJsSyntaxHighlighting.settings[:theme] if theme.blank? || theme == CodeThemeUserSetting::DEFAULT_CODE_THEME

          theme = 'monokai_sublime' if theme.blank?
          return stylesheet_link_tag("themes/#{theme}.css", plugin: 'redmine_highlightjs', media: 'screen') +
                 stylesheet_link_tag('fixes.css', plugin: 'redmine_highlightjs', media: 'screen') +
                 javascript_include_tag('highlight.pack.min.js', plugin: 'redmine_highlightjs') +
                 javascript_include_tag('loader.js', plugin: 'redmine_highlightjs')
        else
          Rails.logger.info "redmine_highlightjs2: *NOT* supported browser: #{user_agent}"
          return ''
        end
      end
    end

    Browser = Struct.new(:browser, :version)

    SUPPORTED_BROWSERS = [Browser.new('Safari', '2'),
                          Browser.new('Firefox', '3'),
                          Browser.new('Chrome', '10'),
                          Browser.new('Internet Explorer', '9')]
  end
end
