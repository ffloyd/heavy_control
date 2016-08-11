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
        ignore_subfolders: []
      }
    end

    def debug(_value = true)
      @config[:debug] = true
    end

    def ignore_subfolder(subfolder)
      @config[:ignore_subfolders] << subfolder
    end
  end
end
