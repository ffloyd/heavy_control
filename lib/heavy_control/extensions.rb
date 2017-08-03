# frozen_string_literal: true

require_relative 'extensions/logging'
require_relative 'extensions/ignore_subfolders'

module HeavyControl
  module Extensions
    def self.apply
      ActiveSupport::Dependencies.singleton_class.prepend HeavyControl::Extensions::IgnoreSubfolders
      ActiveSupport::Dependencies.singleton_class.prepend HeavyControl::Extensions::Logging if HeavyControl.config[:debug]
    end
  end
end
