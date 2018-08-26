class CreateSaleableDays < ActiveRecord::Migration[5.2]
  def change
    create_table :saleable_days do |t|
      t.datetime :date
      t.timestamps
    end
  end
end
