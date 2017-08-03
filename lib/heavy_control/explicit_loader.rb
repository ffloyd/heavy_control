# frozen_string_literal: true

module HeavyControl
  module ExplicitLoader
    class << self
      def apply
        load_consts # explicit loading for production

        ActionDispatch::Reloader.to_prepare do # handle reloading in dev mode
          HeavyControl::ExplicitLoader.load_consts
        end
      end

      def load_consts
        HeavyControl.config[:always_load].each(&:constantize)
      end
    end
  end
end
