# frozen_string_literal: true
require 'spec_helper'

describe HeavyControl::Extensions::IgnoreSubfolders do
  it 'loaded' do
    expect(ActiveSupport::Dependencies.singleton_class.ancestors).to include described_class
  end

  context 'when subfolders is not a module' do
    situation :non_module_subfolder

    it 'fails to load RootClass' do
      expect { RootClass }.to raise_error NameError
    end

    it 'fails to load ContextA::DeepClass' do
      expect { ContextA::DeepClass }.to raise_error NameError
    end

    context 'and we add "ignore_me" to ignored subfolders' do
      before do
        HeavyControl.config do
          ignore_subfolder 'ignore_me'
        end
      end

      it 'loads RootClass' do
        expect { RootClass }.to_not raise_error
      end

      it 'loads ContextA::DeepClass' do
        expect { ContextA::DeepClass }.to_not raise_error
      end
    end
  end
end
