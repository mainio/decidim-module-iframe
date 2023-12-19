# frozen_string_literal: true

Decidim::Iframe.configure do |config|
  if ENV.fetch("FEATURES", nil) == "disabled"
    [
      :allow_images_in_full_editor,
      :allow_images_in_small_editor,
      :allow_images_in_proposals,
      :use_markdown_editor,
      :allow_images_in_markdown_editor,
      :auto_save_forms,
      :intergram_for_admins,
      :intergram_for_public,
      :scoped_styles,
      :proposal_custom_fields,
      :menu,
      :scoped_admins,
      :custom_redirects,
      :validate_title_min_length,
      :validate_title_max_caps_percent,
      :validate_title_max_marks_together,
      :validate_title_start_with_caps,
      :validate_body_min_length,
      :validate_body_max_caps_percent,
      :validate_body_max_marks_together,
      :validate_body_start_with_caps,
      :weighted_proposal_voting,
      :additional_proposal_scopes
    ].each do |conf|
      config.send("#{conf}=", :disabled)
    end

    config.disabled_components = [:iframe_map, :iframe_iframe]
  end
end

if Decidim::Iframe.legacy_version?
  Rails.application.config.to_prepare do
    Decidim::Api::Schema.max_complexity = 5000
    Decidim::Api::Schema.max_depth = 50
  end
end
