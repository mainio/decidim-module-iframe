# frozen_string_literal: true

require "decidim/iframe/version"

module Decidim
  # add a global helper with iframe configuration
  module Iframe
    module IframeHelpers
      # Returns the normalized config for an Organization and the current url
      def iframe_config_instance
        return @iframe_config_instance if @iframe_config_instance

        # if already created in the middleware, reuse it as it might have additional constraints
        @iframe_config_instance = request.env["iframe.current_config"]
        unless @iframe_config_instance.is_a? Config
          @iframe_config_instance = Config.new request.env["decidim.current_organization"]
          @iframe_config_instance.context_from_request request
        end
        @iframe_config_instance
      end

      def iframe_config
        @iframe_config ||= iframe_config_instance.config
      end

      def show_public_intergram?
        return unless iframe_config[:intergram_for_public]
        return true unless iframe_config[:intergram_for_public_settings][:require_login]

        user_signed_in?
      end

      def unfiltered_iframe_config
        @unfiltered_iframe_config ||= iframe_config_instance.unfiltered_config
      end

      def organization_iframe_config
        @organization_iframe_config ||= iframe_config_instance.organization_config
      end

      def iframe_version
        ::Decidim::Iframe::VERSION
      end

      # Collects all CSS that is applied in the current URL context
      def iframe_custom_styles
        @iframe_custom_styles ||= iframe_config_instance.collect_sub_configs_values("scoped_style")
      end

      # Collects all proposal custom fields that is applied in the current URL context
      def iframe_scoped_admins
        @iframe_scoped_admins ||= iframe_config_instance.collect_sub_configs_values("scoped_admin")
      end

      def version_prefix
        "v#{Decidim.version[0..3]}"
      end
    end
  end
end
