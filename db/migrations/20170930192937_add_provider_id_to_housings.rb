Hanami::Model.migration do
  change do
    add_column :housings, :provider_id, BigDecimal, unique: true
  end
end
