Hanami::Model.migration do
  change do
    add_column :housings, :raw_data_blob, "jsonb", default: "{}"
  end
end
