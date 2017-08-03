# frozen_string_literal: true

require 'rails'

require 'heavy_control/extensions'
require 'heavy_control/explicit_loader'

module HeavyControl
  class Railtie < Rails::Railtie
    initializer 'heavy_control', after: :load_config_initializers do
      HeavyControl::Extensions.apply
      HeavyControl::ExplicitLoader.apply
    end
  end
end
