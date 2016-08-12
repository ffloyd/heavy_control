# frozen_string_literal: true
module Situations
  module Helpers
    def self.extended(mod)
      mod.class_eval do
        before(:each) do
          ActiveSupport::Dependencies.clear
          ActiveSupport::Dependencies.history.clear

          HeavyControl.config do
            reset!
            debug
          end
        end
      end
    end

    def situation(name)
      around(:each) do |example|
        ActiveSupport::Dependencies.autoload_paths << File.expand_path("../#{name}", __FILE__)
        example.run
        ActiveSupport::Dependencies.autoload_paths.pop
      end
    end

    def external_class(class_name, scope = Object)
      scope_name = scope.to_s

      around(:each) do |example|
        scope_to_use = scope_name.constantize

        scope_to_use.const_set(class_name, Class.new)
        example.run
        scope_to_use.const_unset(class_name)
      end
    end
  end
end

Object.module_eval do
  # Unset a constant without private access.
  def self.const_unset(const)
    instance_eval { remove_const(const) }
  end
end
