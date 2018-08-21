class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.belongs_to :parent, index: true
      t.string :first_name
      t.string :last_name
      t.integer :age

      t.timestamps
    end
  end
end
