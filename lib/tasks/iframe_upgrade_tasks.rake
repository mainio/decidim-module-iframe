# frozen_string_literal: true

Rake::Task["decidim:webpacker:install"].enhance do
  Rake::Task["decidim_iframe:webpacker:install"].invoke
end

Rake::Task["decidim:webpacker:upgrade"].enhance do
  Rake::Task["decidim_iframe:webpacker:install"].invoke
end
