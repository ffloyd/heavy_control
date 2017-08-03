# frozen_string_literal: true

require 'spec_helper'

describe HeavyControl::ExplicitLoader do
  context 'wrong top-level constant usage' do
    external_const :Parent
    situation :toplevel_bullshit

    subject { CtxA::CtxB::Target.ancestors.map(&:to_s) }

    it 'happens' do
      expect(subject).to include 'Parent'
      expect(subject).to_not include 'CtxA::Parent'
    end

    context 'when we use always_load' do
      before do
        HeavyControl.config do
          always_load 'CtxA::Parent'
        end

        # for specs we need explicitly initiate reloading mechanism =(
        # this code from Rails::ConsoleMethods#reload!
        ActionDispatch::Reloader.cleanup!
        ActionDispatch::Reloader.prepare!
      end

      it 'disappears' do
        expect(subject).to_not  include 'Parent'
        expect(subject).to      include 'CtxA::Parent'
      end
    end
  end
end
