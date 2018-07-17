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
      require_dependency 'redmine_highlightjs/patches/user_preference_patch'

      # Global helpers
      require_dependency 'redmine_highlightjs/helpers'

      # Hooks
      require_dependency 'redmine_highlightjs/hooks'
    end
  end
end
