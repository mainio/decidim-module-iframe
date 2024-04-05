# frozen_string_literal: true

module Decidim
  module Iframe
    # This is the engine that runs on the public interface of `Iframe`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Iframe

      routes do
        root to: "iframe#settings"
      end

      initializer "decidim_iframe.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::Iframe::AdminEngine, at: "/admin/iframe", as: "decidim_admin_iframe"
        end
      end

      def load_seed
        nil
      end
    end
  end
end
