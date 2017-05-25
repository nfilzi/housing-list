Hanami::Model.migration do
  change do
    create_table :trips do
      primary_key :id

      column :destination,     String
      column :travelers_count, Integer
      column :starting_on,     Date
      column :ending_on,       Date

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
