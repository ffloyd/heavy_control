# frozen_string_literal: true

module HeavyControl
  module Extensions
    module Logging
      def load_missing_constant(from_mod, const_name)
        hc_log "Load missing constant '#{const_name}' from #{from_mod}"

        super(from_mod, const_name)
      end

      def require_or_load(file_name, const_path = nil)
        hc_log "Require of load '#{file_name}' with const_path '#{const_path}'"

        super(file_name, const_path)
      end

      def search_for_file(path_suffix)
        hc_log "Search for file with suffix '#{path_suffix}'"

        super(path_suffix).tap do |result|
          hc_log("and found '#{result}'")
        end
      end

      private

      def hc_log(msg)
        Rails.logger.debug "HeavyControl: #{msg}"
      end
    end
  end
end
