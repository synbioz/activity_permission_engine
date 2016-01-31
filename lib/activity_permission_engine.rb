require_relative 'activity_permission_engine/version'
require_relative 'activity_permission_engine/register_activity'
require_relative 'activity_permission_engine/list_activities'
require_relative 'activity_permission_engine/unregister_activity'
require_relative 'activity_permission_engine/allow_activity'
require_relative 'activity_permission_engine/disallow_activity'
require_relative 'activity_permission_engine/check_authorization'
require_relative 'activity_permission_engine/activities_registry'
require_relative 'activity_permission_engine/adapters/activity_permissions_registry/memory'

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

  def self.unregister_activity(request)
    UnregisterActivity.new(request, self.configuration.activity_permissions_registry).call
  end

  def self.allow_activity(request)
    AllowActivity.new(request, self.configuration.activity_permissions_registry).call
  end

  def self.disallow_activity(request)
    DisallowActivity.new(request, self.configuration.activity_permissions_registry).call
  end

  def self.check_authorization(request)
    CheckAuthorization.new(request, self.configuration.activity_permissions_registry).call
  end

  class Configuration
    def initialize(options={})
      @activity_permissions_registry = options.fetch(:activity_permissions_registry, Defaults.activities_permissions_registry)
      @activities = options.fetch(:activities, [])
    end

    attr_accessor :activity_permissions_registry, :activities

    def activities_registry
      @activities_registry ||= ActivitiesRegistry.new(activities)
    end
  end

  module Defaults
    def self.activities_permissions_registry
      Adapters::ActivityPermissionsRegistry::Memory.new
    end
  end
end
