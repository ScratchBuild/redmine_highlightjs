module HighlightJsSyntaxHighlighting
  class << self
    def highlight_by_filename(text, filename)
      Rails.logger.info "redmine_highlightjs: syntax by filename #{filename}"  
      return ERB::Util.h(text)
    end
    def highlight_by_language(text, language)
      Rails.logger.info "redmine_highlightjs: syntax #{language}"
      return ERB::Util.h(text)
    end
  end
end
