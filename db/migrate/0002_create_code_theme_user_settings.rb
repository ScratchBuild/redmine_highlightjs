class CreateCodeThemeUserSettings < Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def self.up
    create_table :code_theme_user_settings do |t|
      t.column :user_id, :integer
      t.column :code_theme, :string
      t.column :updated_at, :timestamp
    end
  end

  def self.down
    drop_table :code_theme_user_settings
  end
end
