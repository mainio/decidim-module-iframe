# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Shakapacker.register_path("#{base_path}/app/packs", prepend: true)

Decidim::Shakapacker.register_entrypoints(
  decidim_iframe: "#{base_path}/app/packs/entrypoints/decidim_iframe.scss"
)

Decidim::Shakapacker.register_stylesheet_import("stylesheets/decidim/iframe/iframe")
