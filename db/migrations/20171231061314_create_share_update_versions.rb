Hanami::Model.migration do
  change do
    create_table :share_update_versions do
      primary_key :version

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
