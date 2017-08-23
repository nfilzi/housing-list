Hanami::Model.migration do
  change do
    add_column :housings, :airbnb_id, BigDecimal, unique: true
  end
end
