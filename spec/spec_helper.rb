# frozen_string_literal: true

ENV['RAILS_ENV'] = 'development' # because we need reloading stuff

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'heavy_control'
require 'pry'

require_relative 'situations/helpers'
RSpec.configure do |c|
  c.extend Situations::Helpers
end

RailsApp =  case Rails::VERSION::MAJOR # rubocop:disable Style/ConstantName
            when 5
              require_relative 'dummies/rails50/config/environment'
              Rails50
            when 4
              require_relative 'dummies/rails42/config/environment'
              Rails42
            end

require 'rails/console/app'
RailsConsole = Class.new { extend Rails::ConsoleMethods }
