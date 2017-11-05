Hanami::Model.migration do
  change do
    add_column :housings, :dismissed, FalseClass, null: false, default: false
  end
end
