# frozen_string_literal: true
require 'spec_helper'

describe HeavyControl do
  it 'has a version number' do
    expect(HeavyControl::VERSION).not_to be nil
  end

  context 'rails dummy app' do
    it 'autoloading works' do
      expect { ApplicationController }.to_not raise_error
    end

    it 'automatically enables autoloading for new dir inside app' do
      expect { RootClass }.to_not raise_error
    end

    it 'cannot autoload files whithin implicit context folders' do
      expect { ClassInsideImplicitContext }.to raise_error NameError
    end
  end
end
