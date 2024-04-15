# frozen_string_literal: true

require "decidim/components/namer"

Decidim::Iframe.register_component(:iframe) do |component|
  component.engine = Decidim::Iframe::Engine
  component.admin_engine = Decidim::Iframe::AdminEngine
  component.icon = "media/images/decidim_meetings.svg" # TODO: create a Icon

  # These actions permissions can be configured in the admin panel
  # component.actions = %w()

  HEIGHT_OPTIONS = %w(16:9 4:3 auto manual_pixel).freeze
  WIDTH_OPTIONS = %w(full_width manual_pixel manual_percentage).freeze

  component.settings(:global) do |settings|
    # Add your global settings
    # Available types: :integer, :boolean
    settings.attribute :announcement, type: :text, translated: true, editor: true
    settings.attribute :src, type: :string, default: ""
    settings.attribute :content_width, type: :select, default: "full_width", choices: -> { WIDTH_OPTIONS }
    settings.attribute :width_value, type: :integer
    settings.attribute :content_height, type: :select, default: "16:9", choices: -> { HEIGHT_OPTIONS }
    settings.attribute :height_value, type: :integer
    settings.attribute :frameborder, type: :boolean, default: false
    settings.attribute :viewport_width, type: :boolean, default: true
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
        content_width: "full_width",
        content_height: "16:9",
        frameborder: false,
        viewport_width: true
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
