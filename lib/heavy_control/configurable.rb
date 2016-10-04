# frozen_string_literal: true
module HeavyControl
  module Configurable
    def config(&block)
      reset! unless @config

      return @config if block.nil?

      instance_eval(&block)
    end

    private

    # DSL methods

    def reset!
      @config = {
        debug: false,
        ignore_subfolders: [],
        always_load: []
      }
    end

    def debug(value = true)
      @config[:debug] = value
    end

    def ignore_subfolder(subfolder)
      @config[:ignore_subfolders] << subfolder
    end

    def always_load(*const_names)
      @config[:always_load] += const_names
    end
  end
end
