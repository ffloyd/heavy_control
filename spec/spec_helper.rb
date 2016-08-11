# frozen_string_literal: true
ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'heavy_control'
require 'pry'

require_relative 'dummies/rails_five/config/environment'
