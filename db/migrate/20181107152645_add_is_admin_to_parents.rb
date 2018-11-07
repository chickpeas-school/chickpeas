class AddIsAdminToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :is_admin, :boolean
  end
end
