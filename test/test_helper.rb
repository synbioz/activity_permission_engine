require 'simplecov'

SimpleCov.start do
  root(File.expand_path('../../', __FILE__))
  add_filter '/test/'
end
require 'minitest/autorun'
require_relative '../lib/activity_permission_engine'
