# frozen_string_literal: true

require "decidim/dev"

ENV["ENGINE_ROOT"] = File.dirname(__dir__)
ENV["NODE_ENV"] ||= "test"

Decidim::Dev.dummy_app_path = File.expand_path(File.join(__dir__, "decidim_dummy_app"))

require "decidim/dev/test/base_spec_helper"

# This re-registration is made because of problems with chromedriver v.120
# Selenium methods are undefined without this change
# More info in PR #12160

require "#{Dir.pwd}/lib/decidim/iframe/test/rspec_support/capybara.rb"
