require_relative '../../activities_registry'

module ActivityPermissionEngine
  module Adapters
    module ActivitiesRegistry
      class Memory
        include ActivityPermissionEngine::ActivitiesRegistry::Interface

        def initialize(store = {})
          @store = store
        end

        def add(activity_ref)
          if store.has_key?(activity_ref)
            false
          else
            store[activity_ref] = []
            true
          end
        end

        def del(activity_ref)
          store.delete(activity_ref)
        end

        def add_role(activity_ref, role_ref)
          store[activity_ref] = store[activity_ref].push(role_ref)
        end

        private
        attr_reader(:store)

        def get_activity_by_ref(activity_ref)
          store.has_key?(activity_ref) ? {activity_ref: activity_ref, role_refs: store[activity_ref]} : false
        end

        def get_all_activities
          store.map {|k,v| {activity_ref: k, role_refs: v} }
        end
      end
    end
  end
end