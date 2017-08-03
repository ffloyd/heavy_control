# frozen_string_literal: true

module HeavyControl
  module ExplicitLoader
    class << self
      def apply
        load_consts # explicit loading for production

        reloader_class.to_prepare do # handle reloading in dev mode
          HeavyControl::ExplicitLoader.load_consts
        end
      end

      def load_consts
        HeavyControl.config[:always_load].each(&:constantize)
      end

      private

      def reloader_class
        case Rails::VERSION::MAJOR
        when 5 then ActiveSupport::Reloader
        when 4 then ActionDispatch::Reloader
        end
      end
    end
  end
end
