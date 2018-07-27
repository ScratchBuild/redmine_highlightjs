require_dependency 'user_preference'

module RedmineHighlightjs
  module Patches
    module UserPreferencePatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          safe_attributes 'code_theme'
        end
      end

      module InstanceMethods
        def code_theme
          code_theme_setting = CodeThemeUserSetting.find_code_theme_by_user_id(user.id)
          return unless code_theme_setting
          code_theme_setting.code_theme
        end

        def code_theme=(name)
          code_theme_setting = CodeThemeUserSetting.find_or_create_code_theme_by_user_id(user.id)
          code_theme_setting.code_theme = name
          code_theme_setting.save!
        end
      end
    end
  end
end
