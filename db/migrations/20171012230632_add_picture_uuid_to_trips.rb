Hanami::Model.migration do
  change do
    add_column :trips, :picture_uuid, String
  end
end
