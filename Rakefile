# frozen_string_literal: true

require "decidim/dev/common_rake"
require "fileutils"

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

def copy_helpers
  FileUtils.mkdir_p "spec/decidim_dummy_app/app/views/v0.11", verbose: true
  FileUtils.cp_r "lib/decidim/iframe/test/layouts", "spec/decidim_dummy_app/app/views/v0.11/layouts", verbose: true
end

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  copy_helpers
end

desc "Generates a development app."
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--demo"
    )
  end

  override_webpacker_config_files("development_app")
  seed_db("development_app")
end
