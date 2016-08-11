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
      expect { ClassInsideIgnoreFolder }.to raise_error NameError
    end

    it 'loads HeavyControl::Railtie' do
      RailsFive::Application.instance.railties.one? { |rt| rt.class == HeavyControl::Railtie }
    end
  end

  context 'configuration' do
    before do
      HeavyControl.config { reset! }
    end

    it 'sets debug' do
      HeavyControl.config { debug }

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

  context 'ignore subfolders feature' do
    before do
      HeavyControl.config { reset! }
    end

    it 'works for root context' do
      HeavyControl.config { ignore_subfolder 'ignore_me' }

      expect { ClassInsideIgnoreFolder }.to_not raise_error
    end

    it 'works when ignore folder inside normal folders' do
      HeavyControl.config { ignore_subfolder 'deep_ignore' }

      expect { ContextA::ContextB::ClassInsideDeepIgnoreFolder }.to_not raise_error
    end
  end
end
