# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe User do
    subject { user }

    let(:user) { create(:user) }

    it { is_expected.to be_valid }

    shared_examples "not admin" do
      it "user respond to admin overrides" do
        expect(User).to respond_to(:iframe_admins_for_current_scope, :iframe_potential_admins)
        expect(User.iframe_admins_for_current_scope).to be_blank
        expect(User.iframe_potential_admins).to be_blank
      end

      it "user is not admin" do
        expect(subject.admin).to be_blank
        expect(subject).not_to be_admin
      end
    end

    shared_examples "is admin" do
      it "user is admin" do
        expect(subject.admin).to be_truthy
        expect(subject).to be_admin
      end
    end
  end
end
