# frozen_string_literal: true

module Decidim
  module Iframe
    module ContextAnalyzers
      autoload :RequestAnalyzer, "decidim/iframe/context_analyzers/request_analyzer"
      autoload :ComponentAnalyzer, "decidim/iframe/context_analyzers/component_analyzer"
      autoload :ParticipatorySpaceAnalyzer, "decidim/iframe/context_analyzers/participatory_space_analyzer"
    end
  end
end
