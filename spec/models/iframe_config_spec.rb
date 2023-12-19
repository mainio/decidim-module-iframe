# frozen_string_literal: true

require "spec_helper"

module Decidim::Iframe
  describe IframeConfig do
    subject { iframe_config }

    let(:organization) { create(:organization) }
    let(:iframe_config) { create(:iframe_config, organization: organization) }

    it { is_expected.to be_valid }

    it "iframe_config is associated with organization" do
      expect(subject).to eq(iframe_config)
      expect(subject.organization).to eq(organization)
    end
  end
end
