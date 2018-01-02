Hanami::Model.migration do
  change do
    create_table :current_time_shares do
      primary_key :id

      column :trading_code,  String, null: false
      column :last_traded_price_for_today,  Float, null: false, default: 0.0
      column :highest_price_for_today,  Float, null: false, default: 0.0
      column :lowest_price_for_today,  Float, null: false, default: 0.0
      column :closing_price_for_today,  Float, null: false, default: 0.0
      column :yesterdays_closing_price,  Float, null: false, default: 0.0
      column :change_for_today,  Float, null: false, default: 0.0
      column :trade_for_today,  Integer, null: false, default: 0
      column :value_million_for_today,  Float, null: false, default: 0.0
      column :volume_for_today,  Integer, null: false, default: 0
      column :fetched_at, DateTime, null: false
      column :version, Integer, null: false
      column :last_traded_price_change_than_last_update, Float, null: false, default: 0.0
      column :value_in_million_change_than_last_update, Float, null: false, default: 0.0
      column :traded_change_than_last_update, Float, null: false, default: 0.0

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
