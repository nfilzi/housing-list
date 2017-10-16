Hanami::Model.migration do
  change do
    add_column :users, :avatar_uuid, String
  end
end
