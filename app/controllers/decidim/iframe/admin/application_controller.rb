# frozen_string_literal: true

module Decidim
  module Iframe
    module Admin
      # This controller is the abstract class from which all other controllers of
      # this engine inherit.
      #
      # Note that it inherits from `Decidim::Admin::Components::BaseController`, which
      # override its layout and provide all kinds of useful methods.
      class ApplicationController < Decidim::Admin::ApplicationController
        def permission_class_chain
          [::Decidim::Iframe::Admin::Permissions] + super
        end

        before_action do
          enforce_permission_to :update, :organization, organization: current_organization
        end
      end
    end
  end
end
