# frozen_string_literal: true

class CreateIframeConfigConstraints < ActiveRecord::Migration[5.2]
  def change
    create_table :iframe_config_constraints do |t|
      t.jsonb :settings

      t.references :iframe_config, null: false, foreign_key: { to_table: :iframe_config }, index: { name: "iframe_config_constraints_config" }
      t.timestamps
      t.index [:settings, :iframe_config_id], name: "index_iframe_settings_iframe_config", unique: true
    end
  end
end
