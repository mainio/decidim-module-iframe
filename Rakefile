# frozen_string_literal: true

require "decidim/dev/common_rake"
require "fileutils"

def override_webpacker_config_files(path)
  Dir.chdir(path) do
    system("bundle exec rake decidim_iframe:webpacker:install")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

def copy_helpers
  FileUtils.mkdir_p "spec/decidim_dummy_app/app/views/v0.11", verbose: true
  FileUtils.cp_r "lib/decidim/iframe/test/layouts", "spec/decidim_dummy_app/app/views/v0.11/layouts", verbose: true
  FileUtils.cp "lib/decidim/iframe/test/initializer.rb", "spec/decidim_dummy_app/config/initializers/iframe.rb", verbose: true
  FileUtils.cp "spec/fixtures/files/tile-0.png", "spec/decidim_dummy_app/public/tile-0.png", verbose: true
end

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  override_webpacker_config_files("spec/decidim_dummy_app")
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
