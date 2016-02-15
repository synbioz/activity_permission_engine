require_relative 'activity_permission_engine/version'
require_relative 'activity_permission_engine/interface_helpers'
require_relative 'activity_permission_engine/framework/request'
require_relative 'activity_permission_engine/register_activity'
require_relative 'activity_permission_engine/list_activities'
require_relative 'activity_permission_engine/unregister_activity'
require_relative 'activity_permission_engine/allow_activity'
require_relative 'activity_permission_engine/disallow_activity'
require_relative 'activity_permission_engine/check_authorization'
require_relative 'activity_permission_engine/activities_registry'
require_relative 'activity_permission_engine/adapters/activity_permissions_registry/memory'
require_relative 'activity_permission_engine/list_activities_permissions'

module ActivityPermissionEngine
  extend InterfaceHelpers

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
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
