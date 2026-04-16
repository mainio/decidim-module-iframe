# frozen_string_literal: true

require "decidim/dev/common_rake"
require "fileutils"

def install_module(path)
  Dir.chdir(path) do
    system("npm i graphql@15.10.1")
  end
end

def copy_helpers
  FileUtils.mkdir_p "spec/decidim_dummy_app/app/views/v0.11", verbose: true
end

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  copy_helpers
  install_module("spec/decidim_dummy_app")
end

desc "Generates a development app."
task :development_app do
  Bundler.with_original_env do
    ENV["DEV_APP_GENERATION"] = "true"

    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--seed_db",
      "--demo"
    )
  end

  install_module("development_app")
end
