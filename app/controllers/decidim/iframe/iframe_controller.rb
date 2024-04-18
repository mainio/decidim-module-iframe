# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeController < Iframe::BlankComponentController
      helper_method :iframe, :remove_margins?, :viewport_width?
      before_action :add_additional_csp_directives, only: :show

      def show; end

      private

      def iframe
        @iframe ||= sanitize(
          element
        ).html_safe
      end

      def element
        case content_height
        when "16:9"
          "<iframe id=\"iFrame\" class=\"aspect-ratio-16 iframe-bottom-margin\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "4:3"
          "<iframe id=\"iFrame\" class=\"aspect-ratio-4 iframe-bottom-margin\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "auto"
          "<iframe id=\"iFrame\" class=\"iframe-bottom-margin\" src=\"#{attributes.src}\" width=\"#{content_width}\"
          frameborder=\"#{frameborder?}\"></iframe>"
        when "manual_pixel"
          "<iframe id=\"iFrame\" class=\"iframe-bottom-margin\" src=\"#{attributes.src}\" width=\"#{content_width}\"
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
        partially_sanitized_html = sanitizer.sanitize(html, tags: %w(iframe), attributes: %w(src id width height frameborder class))
        document = Nokogiri::HTML::DocumentFragment.parse(partially_sanitized_html)
        document.css("iframe").each do |iframe|
          iframe["srcdoc"] = Loofah.fragment(iframe["srcdoc"]).scrub!(:prune).to_s if iframe["srcdoc"]
        end

        document.to_s
      end

      def remove_margins?
        attributes.no_margins
      end

      def viewport_width?
        attributes.viewport_width
      end

      def add_additional_csp_directives
        iframe_urls = Nokogiri::HTML::DocumentFragment.parse(iframe).children.select { |x| x.name == "iframe" }.filter_map { |x| x.attribute("src")&.value }
        return if iframe_urls.blank?

        iframe_urls.each do |url|
          content_security_policy.append_csp_directive("frame-src", url)
        end
      end
    end
  end
end
