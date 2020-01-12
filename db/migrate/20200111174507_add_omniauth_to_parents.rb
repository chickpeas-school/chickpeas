class AddOmniauthToParents < ActiveRecord::Migration[5.2]
  def change
    add_column :parents, :provider, :string
    add_column :parents, :uid, :string
    # add_column :parents, :google_oauth_email, :string

    change_column_null :parents, :encrypted_password, false
  end
end
