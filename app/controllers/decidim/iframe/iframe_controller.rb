# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeController < Iframe::BlankComponentController
      helper_method :iframe, :remove_margins?, :viewport_width?, :resize_iframe
      before_action :add_additional_csp_directives, only: :show

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
        @attributes ||= current_component.settings
      end

      def resize_iframe
        attributes.resize_iframe
      end

      def sanitize(html)
        sanitizer = Rails::Html::SafeListSanitizer.new
        partially_sanitized_html = sanitizer.sanitize(html, tags: %w(iframe), attributes: %w(src id width height frameborder))
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
