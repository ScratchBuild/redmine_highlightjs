module RedmineHighlightjs
  class << self
    def settings
      ActionController::Parameters.new(Setting[:plugin_redmine_highlightjs])
    end

    def setting?(value)
      true?(settings[value])
    end

    def true?(value)
      return true if value.to_i == 1 || value.to_s.casecmp('true').zero?
      false
    end

    def highlight_by_filename(text, filename)
      Rails.logger.info "redmine_highlightjs: syntax by filename #{filename}"
      ERB::Util.h(text)
    end

    def highlight_by_language(text, language)
      Rails.logger.info "redmine_highlightjs: syntax #{language}"
      ERB::Util.h(text)
    end

    def setup
      # Patches
      UserPreference.send(:include, RedmineHighlightjs::Patches::UserPreferencePatch)
      ActionView::Base.send :include, RedmineHighlightjs::Helpers

      # Hooks
      require_dependency 'redmine_highlightjs/hooks'
    end
  end
end
