# frozen_string_literal: true

if !Rails.env.production? || ENV.fetch("SEED", nil)
  print "Creating seeds for iframe...\n" unless Rails.env.test?

  organization = Decidim::Organization.first

  # Set the htmleditor on to facilitate development
  admin_user = Decidim::User.find_by(
    organization: organization,
    email: "admin@example.org"
  )

  Decidim.traceability.update!(
    organization,
    admin_user,
    rich_text_editor_in_public_views: true
  )

end
