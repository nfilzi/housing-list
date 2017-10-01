Hanami::Model.migration do
  change do
    add_column :housings, :imported, FalseClass, null: false, default: false
  end
end
