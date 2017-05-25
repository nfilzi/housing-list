Hanami::Model.migration do
  change do
    create_table :trip_organizers do
      primary_key :id

      foreign_key :trip_id,      :trips, null: false, on_delete: :cascade
      foreign_key :organizer_id, :users, null: false, on_delete: :cascade

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :trip_id
      index :organizer_id
    end
  end
end
