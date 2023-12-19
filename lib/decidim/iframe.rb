# frozen_string_literal: true

require "decidim/iframe/iframe"
require "decidim/iframe/engine"
require "decidim/iframe/admin_engine"
require "decidim/iframe/context_analyzers"
require "decidim/iframe/iframe_component/engine"
require "decidim/iframe/iframe_component/admin_engine"
require "decidim/iframe/iframe_component/component"

# Engines to handle logic unrelated to participatory spaces or components

Decidim.register_global_engine(
  :decidim_iframe, # this is the name of the global method to access engine routes
  ::Decidim::Iframe::Engine,
  at: "/iframe"
)
