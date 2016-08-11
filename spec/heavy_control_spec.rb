# frozen_string_literal: true
require 'spec_helper'

describe HeavyControl do
  it 'has a version number' do
    expect(HeavyControl::VERSION).not_to be nil
  end

  it 'rails autoloading works' do
    expect { ApplicationController }.to_not raise_error
  end
end
