# frozen_string_literal: true

module Decidim
  module Iframe
    class IframeConfig < ApplicationRecord
      self.table_name = "iframe_config"

      belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"

      has_many :constraints,
               foreign_key: "iframe_config_id",
               class_name: "Decidim::Iframe::ConfigConstraint",
               dependent: :destroy

      validates :var, uniqueness: { scope: :decidim_organization_id }

      def additional_constraints
        @additional_constraints ||= []
      end

      def add_constraints(constraints)
        return if constraints.blank?

        additional_constraints.concat(constraints.respond_to?(:each) ? constraints : [constraints])
      end

      def self.for_organization(organization)
        where(organization: organization)
      end

      # use this instead of "constraints" to evaluate dynamically added constants
      def all_constraints
        constraints + additional_constraints
      end
    end
  end
end
