# frozen_string_literal: true

require "rails"
require "deface"
require "decidim/core"

module Decidim
  module Iframe
    # This is the engine that runs on the public interface of iframe.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Iframe

      routes do
        post :editor_images, to: "editor_images#create"
      end

      # Prepare a zone to create overrides
      # https://edgeguides.rubyonrails.org/engines.html#overriding-models-and-controllers
      # overrides
      config.to_prepare do
        # activate Decidim LayoutHelper for the overriden views
        ActiveSupport.on_load :action_controller do
          helper Decidim::LayoutHelper if respond_to?(:helper)
        end

        # Late registering of components to take into account initializer values
        Iframe.registered_components.each do |manifest, block|
          next if Decidim.find_component_manifest(manifest)

          Decidim.register_component(manifest, &block)
        end
      end

      initializer "decidim_iframe.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      # Votings may override proposals cells, let's be sure to add these paths after the proposal component initializer
      initializer "decidim_iframe.add_cells_view_paths", before: "decidim_proposals.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Iframe::Engine.root}/app/views")
      end
    end
  end
end
