class AddParentToEmailConfig < ActiveRecord::Migration[5.2]
  def change
    add_reference :email_configs, :parent, foreign_key: true
  end
end
