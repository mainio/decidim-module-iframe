# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeController < Iframe::BlankComponentController
      ALLOWED_ATTRIBUTES = %w(src id width height frameborder title allow allowpaymentrequest name referrerpolicy sandbox srcdoc allowfullscreen).freeze
      helper_method :iframe, :remove_margins?, :viewport_width?, :resize_iframe

      def show; end

      private

      def iframe
        @iframe ||= sanitize(
          element
        ).html_safe
      end

      def element
        case resize_iframe
        when "responsive"
          "<iframe id=\"iFrame\" src=\"#{attributes.src}\" width=\"#{attributes.width}\"
          frameborder=\"#{attributes.frameborder}\"></iframe>"
        when "manual"
          "<iframe id=\"iFrame\" src=\"#{attributes.src}\" width=\"#{attributes.width}\"
          height=\"#{attributes.height}\"frameborder=\"#{attributes.frameborder}\"></iframe>"
        end
      end

      def attributes
        current_component.settings
      end

      def resize_iframe
        attributes.resize_iframe
      end

      def sanitize(html)
        sanitizer = Rails::Html::SafeListSanitizer.new
        sanitizer.sanitize(html, tags: %w(iframe), attributes: ALLOWED_ATTRIBUTES)
      end

      def remove_margins?
        current_component.settings.no_margins
      end

      def viewport_width?
        current_component.settings.viewport_width
      end
    end
  end
end
