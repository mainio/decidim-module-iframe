# frozen_string_literal: true

module Decidim
  module Iframe
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    #
    class ApplicationController < Decidim::ApplicationController
      def permission_class_chain
        [::Decidim::Iframe::Permissions] + super
      end
    end
  end
end
