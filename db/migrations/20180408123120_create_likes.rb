Hanami::Model.migration do
  change do
    create_table :likes do
      primary_key :id
      foreign_key :housing_id, :housings, null: false, on_delete: :cascade
      foreign_key :user_id,    :users,    null: false, on_delete: :cascade

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index [:housing_id, :user_id], unique: true
    end
  end
end
