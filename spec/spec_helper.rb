# frozen_string_literal: true
ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'heavy_control'
require 'pry'

case Rails::VERSION::MAJOR
when 5
  require_relative 'dummies/rails_five/config/environment'
  RailsApp = RailsFive
when 4
  require_relative 'dummies/rails_four/config/environment'
  RailsApp = RailsFour
end
