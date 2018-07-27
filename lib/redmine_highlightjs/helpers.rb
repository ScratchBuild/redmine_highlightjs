module RedmineHighlightjs
  module Helpers
    def code_theme
      setting = CodeThemeUserSetting.find_code_theme_by_user_id(User.current.id)
      return Setting.ui_theme unless setting
      return Setting.ui_theme if setting.code_theme == CodeThemeUserSetting::DEFAULT_CODE_THEME
      setting.code_theme_name
    end
  end
end
