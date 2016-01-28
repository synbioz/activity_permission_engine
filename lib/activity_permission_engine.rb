require_relative 'activity_permission_engine/version'
require_relative 'activity_permission_engine/register_activity'
require_relative 'activity_permission_engine/list_activities'

module ActivityPermissionEngine
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.register_activity(request)
    RegisterActivity.new(request, self.configuration.activities_registry).call
  end

  def self.list_activities
    ListActivities.new(self.configuration.activities_registry).call
  end

  class Configuration
    def initialize(options={})
      @activities_registry = options.fetch(:activities_registry, Defaults.activities_registry)
    end

    attr_accessor :activities_registry
  end

  module Defaults
    def self.activities_registry
      # TODO: return a simple file based registry
    end
  end
end
