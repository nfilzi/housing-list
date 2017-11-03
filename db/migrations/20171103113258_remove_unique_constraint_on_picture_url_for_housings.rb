Hanami::Model.migration do
  change do
    alter_table :housings do
      drop_constraint :housings_picture_url_key
    end
  end
end
