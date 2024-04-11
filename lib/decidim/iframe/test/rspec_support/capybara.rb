# frozen_string_literal: true

# This re-registration file is made because of problems with chromedriver v.120
# Selenium methods are undefined without this change
# More info in PR #12160

require "selenium-webdriver"

module Decidim
  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new

    options.add_argument("--headless=new") if ENV["HEADLESS"]
    options.add_argument("--no-sandbox")

    window_size = ENV["BIG_SCREEN_SIZE"].present? ? "1920,3000" : "1920,1080"
    options.add_argument("--window-size=#{window_size}")

    options.add_argument("--ignore-certificate-errors") if ENV["TEST_SSL"]
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options:
    )
  end
end
