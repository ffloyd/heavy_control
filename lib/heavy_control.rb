# frozen_string_literal: true

require 'heavy_control/version'
require 'heavy_control/railtie'
require 'heavy_control/configurable'

module HeavyControl
  extend HeavyControl::Configurable
end
