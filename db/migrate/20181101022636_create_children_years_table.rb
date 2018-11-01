class CreateChildrenYearsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :children_years, id: false do |t|
      t.belongs_to :child, index: true
      t.belongs_to :year, index: true
    end
  end
end
