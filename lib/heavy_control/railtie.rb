# frozen_string_literal: true
require 'rails'

require 'heavy_control/extensions'

module HeavyControl
  class Railtie < Rails::Railtie
    initializer 'heavy_control.logging', after: :load_config_initializers do
      HeavyControl::Extensions.apply
    end
  end
end
