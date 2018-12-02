class AddSentToMassMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :mass_messages, :sent, :boolean
  end
end
