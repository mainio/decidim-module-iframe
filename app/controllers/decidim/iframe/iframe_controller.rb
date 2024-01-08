# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeController < Iframe::BlankComponentController
      helper_method :iframe, :remove_margins?, :viewport_width?, :resize_iframe

      private

      def iframe
        @iframe ||= sanitize(
          element
        ).html_safe
      end

      def element
        settings = attributes

        case resize_iframe
        when "responsive"
          "<iframe id=\"iFrame\" src=\"#{settings.src}\" width=\"#{settings.width}\"
          frameborder=\"#{settings.frameborder}\"></iframe>"
        when "manual"
          "<iframe id=\"iFrame\" src=\"#{attributes.src}\" width=\"#{settings.width}\"
          height=\"#{settings.height}\"frameborder=\"#{settings.frameborder}\"></iframe>"
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
        sanitizer.sanitize(html, tags: %w(iframe), attributes: %w(src id width height frameborder))
      end

      def remove_margins?
        attributes.no_margins
      end

      def viewport_width?
        attributes.viewport_width
      end
    end
  end
end
