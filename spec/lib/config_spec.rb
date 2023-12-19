# frozen_string_literal: true

require "spec_helper"

module Decidim::Iframe
  describe Config do
    subject { described_class.new organization }

    let(:organization) { create :organization }
    let(:participatory_process) { create :participatory_process, organization: organization }
    let(:component) { create(:dummy_component, participatory_space: participatory_process) }
    let(:config) do
      Decidim::Iframe.config
    end

    let(:request) { double(url: "/processes/some-slug/f/12") }

    it "has a basic config" do
      expect(subject.config).to eq(config)
    end

    it "converts url to context" do
      subject.context_from_request(request)
      expect(subject.context).to eq(participatory_space_manifest: "participatory_processes", participatory_space_slug: "some-slug", component_id: "12")
    end

    context "when url is in the admin" do
      let(:request) { double(url: "/admin/participatory_processes/natus-molestias/edit") }

      it "converts url to context" do
        subject.context_from_request(request)
        expect(subject.context).to eq(participatory_space_manifest: "participatory_processes", participatory_space_slug: "natus-molestias")
      end

      context "and url manages component" do
        let(:request) { double(url: "/admin/participatory_processes/natus-molestias/components/9/manage/") }

        it "converts url to context" do
          subject.context_from_request(request)
          expect(subject.context).to eq(participatory_space_manifest: "participatory_processes", participatory_space_slug: "natus-molestias", component_id: "9")
        end
      end

      context "and url is process group" do
        let(:request) { double(url: "/participatory_process_groups/123") }

        it "converts url to context" do
          subject.context_from_request(request)
          expect(subject.context).to eq(participatory_space_manifest: "process_groups", participatory_space_slug: "123")
        end
      end

      context "and url is not a participatory space" do
        let(:request) { double(url: "/admin/newsletters/new") }

        it "converts url to context" do
          subject.context_from_request(request)
          expect(subject.context).to eq(participatory_space_manifest: "system")
        end
      end
    end

    context "when url does not match anything" do
      let(:request) { double(url: "/newsletters") }

      it "returns empty context" do
        subject.context_from_request(request)
        expect(subject.context).to be_empty
      end
    end

    it "converts component to context" do
      subject.context_from_component(component)
      expect(subject.context).to eq(
        participatory_space_manifest: participatory_process.manifest.name.to_s,
        participatory_space_slug: participatory_process.slug,
        component_id: component.id.to_s,
        component_manifest: component.manifest.name.to_s
      )
    end

    it "converts participatory_space to context" do
      subject.context_from_participatory_space(participatory_process)
      expect(subject.context).to eq(
        participatory_space_manifest: participatory_process.manifest.name.to_s,
        participatory_space_slug: participatory_process.slug
      )
    end
  end
end
