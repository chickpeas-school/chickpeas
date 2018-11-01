class DropParentsYears < ActiveRecord::Migration[5.2]
  def change
    drop_table :parents_years
  end
end
