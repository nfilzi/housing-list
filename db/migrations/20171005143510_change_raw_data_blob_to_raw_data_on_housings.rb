Hanami::Model.migration do
  change do
    alter_table :housings do
      rename_column :raw_data_blob, :raw_data
    end
  end
end
