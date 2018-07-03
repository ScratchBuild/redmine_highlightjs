class CodeThemeUserSetting < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  DEFAULT_CODE_THEME = '__default_code_theme__'.freeze

  def self.code_themes
    data = YAML.safe_load(ERB.new(IO.read(Rails.root.join('plugins',
                                                          'redmine_highlightjs',
                                                          'config',
                                                          'themes.yml'))).result) || {}
    themes = {}
    data.each do |theme|
      name = theme.tr('-', ' ')
      themes[name] = theme
    end
    themes
  end

  def self.find_code_theme_by_user_id(user_id)
    CodeThemeUserSetting.find(:first, conditions: ['user_id = ?', user_id])
  rescue ActiveRecord::RecordNotFound
    CodeThemeUserSetting.find_by(user_id: user_id)
  end

  def self.find_or_create_code_theme_by_user_id(user_id)
    code_theme = find_code_theme_by_user_id(user_id)
    unless code_theme
      code_theme = CodeThemeUserSetting.new
      code_theme.user_id = user_id
    end
    code_theme
  end

  def code_theme_name
    return '' if code_theme == DEFAULT_CODE_THEME
    code_theme
  end
end
