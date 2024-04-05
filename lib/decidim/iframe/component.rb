# frozen_string_literal: true

require "decidim/components/namer"

Decidim::Iframe.register_component(:iframe) do |component|
  component.engine = Decidim::Iframe::Engine
  component.admin_engine = Decidim::Iframe::AdminEngine
  component.icon = "media/images/decidim_meetings.svg" # TODO: create a Icon

  # These actions permissions can be configured in the admin panel
  # component.actions = %w()

  RESIZE_OPTIONS = %w(responsive manual).freeze

  component.settings(:global) do |settings|
    # Add your global settings
    # Available types: :integer, :boolean
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :src, type: :string, default: ""
    settings.attribute :width, type: :string, default: "100%"
    settings.attribute :frameborder, type: :integer, default: "0"
    settings.attribute :resize_iframe, type: :select, default: "responsive", choices: -> { RESIZE_OPTIONS }
    settings.attribute :height, type: :string, default: ""
    settings.attribute :viewport_width, type: :boolean, default: false
  end

  component.settings(:step) do |settings|
    # Add your settings per step
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :src, type: :string, default: ""
    settings.attribute :width, type: :string, default: "100%"
    settings.attribute :frameborder, type: :integer, default: "0"
  end

  # component.register_stat :some_stat do |context, start_at, end_at|
  #   # Register some stat number to the application
  # end

  component.seeds do |participatory_space|
    # Create a Iframe component in all participatory spaces
    admin_user = Decidim::User.find_by(
      organization: participatory_space.organization,
      email: "admin@example.org"
    )

    params = {
      name: Decidim::Components::Namer.new(participatory_space.organization.available_locales, :iframe).i18n_name,
      manifest_name: :iframe,
      published_at: Time.current,
      participatory_space:,
      settings: {
        announcement: { en: Faker::Lorem.paragraphs(number: 2).join("\n") },
        src: "",
        width: "100%",
        frameborder: "0",
        resize_iframe: "responsive",
        height: ""
      }
    }

    component = Decidim.traceability.perform_action!(
      "publish",
      Decidim::Component,
      admin_user,
      visibility: "all"
    ) do
      Decidim::Component.create!(params)
    end
  end
end
