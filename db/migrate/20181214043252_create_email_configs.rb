class CreateEmailConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :email_configs do |t|
      t.string :email
      t.string :genre
      t.text :description
      t.boolean :testing

      t.timestamps
    end

    EmailConfig.create(email: "brad@prudl.com", genre: "saleable_days", description: "The default email config", testing: true)
  end
end
