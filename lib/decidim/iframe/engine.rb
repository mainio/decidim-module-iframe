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
        root to: "iframe#show"
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

      Capybara.register_driver :headless_chrome do |app|
        options = ::Selenium::WebDriver::Chrome::Options.new
        options.args << "--headless=new"
        options.args << "--no-sandbox"
        options.args << if ENV["BIG_SCREEN_SIZE"].present?
                          "--window-size=1920,3000"
                        else
                          "--window-size=1920,1080"
                        end
        options.args << "--ignore-certificate-errors" if ENV["TEST_SSL"]
        Capybara::Selenium::Driver.new(
          app,
          browser: :chrome,
          capabilities: [options]
        )
      end

      def load_seed
        nil
      end
    end
  end
end
