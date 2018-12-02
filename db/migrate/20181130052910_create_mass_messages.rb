class CreateMassMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :mass_messages do |t|
      t.text :message
      t.timestamps
    end

    create_table :mass_messages_parents, id: false do |t|
      t.belongs_to :mass_message
      t.belongs_to :parent
    end
  end
end
