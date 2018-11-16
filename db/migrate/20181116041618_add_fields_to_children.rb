class AddFieldsToChildren < ActiveRecord::Migration[5.2]
  def change
    add_column :children, :dob, :string
    add_column :children, :days, :string

    add_column :parents, :phone_number, :string
    add_column :parents, :job, :string
    add_column :parents, :address, :string
  end
end
