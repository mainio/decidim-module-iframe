# frozen_string_literal: true

class ChangeIframeConfigVarType < ActiveRecord::Migration[5.2]
  def change
    change_column :iframe_config, :var, :string

    Decidim::Iframe::IframeConfig.find_each do |config|
      config.var.gsub!('"', "")
      config.save!
    end
  end
end
