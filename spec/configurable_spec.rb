# frozen_string_literal: true
require 'spec_helper'

describe HeavyControl::Configurable do
  it 'sets debug' do
    HeavyControl.config do
      reset!
      debug
    end

    expect(HeavyControl.config[:debug]).to eq true
  end

  it 'adds ignore subfolders' do
    HeavyControl.config do
      ignore_subfolder 'operations'
      ignore_subfolder 'cells'
    end

    expect(HeavyControl.config[:ignore_subfolders]).to eq %w(operations cells)
  end

  it 'resets to default' do
    HeavyControl.config do
      debug
      ignore_subfolder 'operations'

      reset!
    end

    expect(HeavyControl.config[:debug]).to eq false
    expect(HeavyControl.config[:ignore_subfolders]).to eq []
  end
end
