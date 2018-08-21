class CreateParents < ActiveRecord::Migration[5.2]
  def change
    create_table :parents do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :years

      t.timestamps
    end
  end
end
