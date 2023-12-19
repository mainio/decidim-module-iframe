# frozen_string_literal: true

module Decidim
  module Iframe
    # This is the engine that runs on the public interface of `Iframe`.
    class AdminEngine < ::Rails::Engine

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        resources :constraints
        resources :custom_redirects, except: [:show]
        resources :config, param: :var, only: [:show, :update]
        resources :scoped_styles, param: :var, only: [:create, :destroy]
        resources :scoped_admins, param: :var, only: [:create, :destroy]
        get :admin_accountability, to: "admin_accountability#index", as: "admin_accountability"
        post :export_admin_accountability, to: "admin_accountability#export", as: "export_admin_accountability"
        get :users, to: "config#users"
        post :rename_scope_label, to: "config#rename_scope_label"
        get :checks, to: "checks#index"
        post :migrate_images, to: "checks#migrate_images"
        root to: "config#show"
      end

      initializer "decidim_iframe.admin_mount_routes" do
        Decidim::Core::Engine.routes do
          mount Decidim::Iframe::AdminEngine, at: "/admin/iframe", as: "decidim_admin_iframe"
        end
      end

      def load_seed
        nil
      end
    end
  end
end
