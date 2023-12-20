# frozen_string_literal: true

module Decidim
  module Iframe
    include ActiveSupport::Configurable

    def self.registered_components
      @registered_components ||= []
    end

    # Wrap registered components to register it later, after initializing
    # so we can honor disabled_components config
    def self.register_component(manifest, &block)
      registered_components << [manifest, block]
    end
  end
end
