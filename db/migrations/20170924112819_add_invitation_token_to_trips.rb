Hanami::Model.migration do
  change do
    add_column :trips, :invitation_token, String, null: false
  end
end
