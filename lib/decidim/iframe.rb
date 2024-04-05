# frozen_string_literal: true

require "decidim/iframe/iframe"
require "decidim/iframe/engine"
require "decidim/iframe/component"
require "decidim/iframe/admin_engine"

# Engines to handle logic unrelated to participatory spaces or components

Decidim.register_global_engine(
  :decidim_iframe, # this is the name of the global method to access engine routes
  Decidim::Iframe::Engine,
  at: "/iframe"
)
