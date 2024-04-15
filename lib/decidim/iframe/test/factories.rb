# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/proposals/test/factories"
require "decidim/surveys/test/factories"

FactoryBot.define do
  factory :iframe_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :proposals).i18n_name }
    manifest_name { :iframe }
    participatory_space { association(:participatory_process, :with_steps, organization:) }
  end
end
