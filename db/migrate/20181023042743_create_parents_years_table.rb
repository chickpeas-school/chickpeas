class CreateParentsYearsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :parents_years, id: false do |t|
      t.belongs_to :parent, index: true
      t.belongs_to :year, index: true
    end
  end
end
