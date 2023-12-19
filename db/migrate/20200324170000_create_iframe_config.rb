# frozen_string_literal: true

class CreateIframeConfig < ActiveRecord::Migration[5.2]
  def change
    create_table :iframe_config do |t|
      t.jsonb :var
      t.jsonb :value
      t.integer :decidim_organization_id,
                foreign_key: true,
                index: { name: "index_iframe_on_decidim_organization_id" }

      t.timestamps
      t.index [:var, :decidim_organization_id], name: "index_iframe_organization_var", unique: true
    end
  end
end
