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

  it 'unsets debug' do
    HeavyControl.config do
      reset!
      debug
      debug false
    end

    expect(HeavyControl.config[:debug]).to eq false
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
      always_load 'SomeClass'

      reset!
    end

    expect(HeavyControl.config[:debug]).to eq false
    expect(HeavyControl.config[:ignore_subfolders]).to eq []
    expect(HeavyControl.config[:always_load]).to eq []
  end

  it 'populates always_load with const names' do
    HeavyControl.config do
      always_load 'OneArg'
      always_load 'Several', 'Args'
    end

    expect(HeavyControl.config[:always_load]).to eq %w(OneArg Several Args)
  end
end
