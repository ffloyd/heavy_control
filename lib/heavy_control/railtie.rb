# frozen_string_literal: true
require 'rails'

require 'heavy_control/extensions'

module HeavyControl
  class Railtie < Rails::Railtie
    initializer 'heavy_control.extensions' do
      ActiveSupport::Dependencies.singleton_class.prepend Extensions::Logging
    end
  end
end
