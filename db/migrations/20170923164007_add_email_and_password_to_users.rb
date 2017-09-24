Hanami::Model.migration do
  change do
    add_column :users, :email,              String, null: false, unique: true
    add_column :users, :encrypted_password, String, null: false

    add_index  :users, :email, unique: true
  end
end
