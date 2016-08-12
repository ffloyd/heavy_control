# frozen_string_literal: true
require 'spec_helper'

describe 'Unhandled situations' do
  context 'wrong top-level constant usage:' do
    external_const :Parent
    situation :toplevel_bullshit

    subject { CtxA::CtxB::Target.ancestors.map(&:to_s) }

    it 'happens' do
      expect(subject).to include 'Parent'
      expect(subject).to_not include 'CtxA::Parent'
    end
  end
end
