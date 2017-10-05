Hanami::Model.migration do
  change do
    add_column :housings, :picture_url, String, unique: true
  end
end
