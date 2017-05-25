Hanami::Model.migration do
  change do
    create_table :housings do
      primary_key :id

      foreign_key :trip_id, :trips, null: false, on_delete: :cascade
      foreign_key :user_id, :users, on_delete: :set_null

      column :title,       String
      column :description, String
      column :url,         String
      column :provider,    String
      column :total_price, Integer

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :trip_id
      index :user_id
    end
  end
end
