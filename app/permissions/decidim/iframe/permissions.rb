# frozen_string_literal: true

module Decidim
  module Iframe
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action if permission_action.scope == :public && public_action_allowed?
        return permission_action unless user

        permission_action
      end

      private

      def public_action_allowed?
        return false unless permission_action.subject == :iframe && permission_action.action == :read

        allow!
      end
    end
  end
end
