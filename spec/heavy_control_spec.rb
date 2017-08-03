# frozen_string_literal: true

require 'spec_helper'

describe HeavyControl do
  it 'has a version number' do
    expect(HeavyControl::VERSION).not_to be nil
  end

  # this context tests default rails behaviour. It's useful when we first time run tests against new rails/ruby version.
  context 'rails dummy app' do
    it 'autoloading works' do
      expect { ApplicationController }.to_not raise_error
    end

    # you should create app/test_me/autoloading_test_class.rb inside new dummy app
    it 'automatically enables autoloading for new dir inside app' do
      expect { AutoloadingTestClass }.to_not raise_error
    end

    it 'loads HeavyControl::Railtie' do
      RailsApp::Application.instance.railties.one? { |rt| rt.class == HeavyControl::Railtie }
    end

    # you should enable debug in heavy_control.rb initializer inside new dummy app
    # it's useful when debugging
    it 'has enabled debug' do
      expect(ActiveSupport::Dependencies.singleton_class.ancestors).to include HeavyControl::Extensions::Logging
    end
  end

  # test situations helpers
  # rubocop:disable Lint/Void
  context 'situation helpers:' do
    context '.external_const' do
      external_const 'ExternalClass'
      external_const 'ChildExternalClass', 'ExternalClass'
      external_const 'ExternalModule', as_module: true

      it 'creates classes' do
        expect { ExternalClass }.to_not raise_error
        expect { ExternalClass::ChildExternalClass }.to_not raise_error
        expect(ExternalClass).to be_a Class
        expect(ExternalClass::ChildExternalClass).to be_a Class
      end

      it 'creates modules' do
        expect { ExternalModule }.to_not raise_error
        expect(ExternalModule.class).to eq Module
      end

      it 'does not involve autoloading' do
        ExternalClass
        ExternalClass::ChildExternalClass
        expect(ActiveSupport::Dependencies.loaded).to be_empty
      end
    end

    context '.situation' do
      situation :one_file

      it 'adds class to autoload' do
        expect { AloneClass }.to_not raise_error
      end

      it 'involves autoloading' do
        AloneClass
        expect(ActiveSupport::Dependencies.loaded).to_not be_empty
      end

      # we need Rails config's `cache_classes = true` to make this works.
      it 'clears loaded stuff between requests and ActiveSupport::Dependencies.clear works as expected' do
        expect(ActiveSupport::Dependencies.loaded).to be_empty
        expect(defined?(AloneClass)).to be_falsey

        AloneClass
        expect(ActiveSupport::Dependencies.loaded).to_not be_empty

        ActiveSupport::Dependencies.clear
        expect(ActiveSupport::Dependencies.loaded).to be_empty
        AloneClass
        expect(ActiveSupport::Dependencies.loaded).to_not be_empty
      end
    end
  end
  # rubocop:enable Lint/Void
end
