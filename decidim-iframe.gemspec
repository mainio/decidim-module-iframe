# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/iframe/version"

Gem::Specification.new do |s|
  s.version = Decidim::Iframe.version
  s.authors = ["Joonas Aapro"]
  s.email = ["joonas.aapro@mainiotech.fi"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/mainio/decidim-module-iframe"
  s.required_ruby_version = ">= 3.0"

  s.name = "decidim-iframe"
  s.summary = "A decidim iframe module"
  s.description = "Some usability and UX tweaks for Decidim."

  s.files = Dir["{app,config,lib,vendor,db}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "package.json", "README.md", "CHANGELOG.md"]

  s.add_dependency "decidim-admin", Decidim::Iframe.decidim_version
  s.add_dependency "decidim-core", Decidim::Iframe.decidim_version
  s.add_dependency "deface", ">= 1.5"
  s.add_dependency "sassc", "~> 2.3" # TODO: check if this can be removed

  s.add_development_dependency "decidim-dev", Decidim::Iframe.decidim_version
  s.metadata["rubygems_mfa_required"] = "true"
end
