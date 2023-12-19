# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Iframe
    module IframeComponent
      # This is the engine is used to create the component Map.
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::Iframe::IframeComponent

        routes do
          root to: "iframe#show"
        end

        def load_seed
          nil
        end
      end
    end
  end
end
