class CreateYears < ActiveRecord::Migration[5.2]
  def change
    create_table :years do |t|
      t.integer :value
      t.boolean :current_year

      t.timestamps
    end
  end
end
