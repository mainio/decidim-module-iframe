# frozen_string_literal: true

require "decidim/gem_manager"

namespace :decidim_iframe do
  namespace :webpacker do
    desc "Installs Iframe webpacker files in Rails instance application"
    task install: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_iframe_npm
    end

    desc "Adds Iframe dependencies in package.json"
    task upgrade: :environment do
      raise "Decidim gem is not installed" if decidim_path.nil?

      install_iframe_npm
    end

    def install_iframe_npm
      iframe_npm_dependencies.each do |type, packages|
        puts "install NPM packages. You can also do this manually with this command:"
        puts "npm i --save-#{type} #{packages.join(" ")}"
        system! "npm i --save-#{type} #{packages.join(" ")}"
      end
    end

    def iframe_npm_dependencies
      @iframe_npm_dependencies ||= begin
        package_json = JSON.parse(File.read(iframe_path.join("package.json")))

        {
          prod: package_json["dependencies"].map { |package, version| "#{package}@#{version}" },
          dev: package_json["devDependencies"].map { |package, version| "#{package}@#{version}" }
        }.freeze
      end
    end

    def iframe_path
      @iframe_path ||= Pathname.new(iframe_gemspec.full_gem_path) if Gem.loaded_specs.has_key?(gem_name)
    end

    def iframe_gemspec
      @iframe_gemspec ||= Gem.loaded_specs[gem_name]
    end

    def rails_app_path
      @rails_app_path ||= Rails.root
    end

    def copy_iframe_file_to_application(origin_path, destination_path = origin_path)
      FileUtils.cp(iframe_path.join(origin_path), rails_app_path.join(destination_path))
    end

    def system!(command)
      system("cd #{rails_app_path} && #{command}") || abort("\n== Command #{command} failed ==")
    end

    def gem_name
      "decidim-iframe"
    end
  end
end
