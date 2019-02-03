class ChangeEmailConfigTestingToActive < ActiveRecord::Migration[5.2]
  def change
    rename_column :email_configs, :testing, :active
  end
end
