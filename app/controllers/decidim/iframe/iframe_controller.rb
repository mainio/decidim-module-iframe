# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeController < Iframe::BlankComponentController
      helper_method :iframe, :remove_margins?, :viewport_width?, :content_height

      private

      def iframe
        @iframe ||= sanitize(
          element
        ).html_safe
      end

      def element
        case content_height
        when "16:9"
          "<iframe id=\"iFrame\" class=\"aspect-ratio-16\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "4:3"
          "<iframe id=\"iFrame\" class=\"aspect-ratio-4\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "auto"
          "<iframe id=\"iFrame\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "manual_pixel"
          "<iframe id=\"iFrame\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          height=\"#{attributes.height_value}px\"frameborder=\"#{frameborder?}\"></iframe>"
        end
      end

      def attributes
        @attributes ||= current_component.settings
      end

      def frameborder?
        if attributes.frameborder
          "1"
        else
          "0"
        end
      end

      def content_height
        attributes.content_height
      end

      def content_width
        case attributes.content_width
        when "full_width"
          "100%"
        when "manual_pixel"
          "#{attributes.width_value}px"
        when "manual_percentage"
          "#{attributes.width_value}%"
        end
      end

      def sanitize(html)
        sanitizer = Rails::Html::SafeListSanitizer.new
        sanitizer.sanitize(html, tags: %w(iframe), attributes: %w(src id width height frameborder class))
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
