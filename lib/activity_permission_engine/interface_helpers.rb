module ActivityPermissionEngine
  module InterfaceHelpers
    def register_activity(activity_ref)
      RegisterActivity::Request.new(activity_ref).response
    end

    def list_activities
      ListActivities::Request.new.response
    end

    def unregister_activity(activity_ref)
      UnregisterActivity::Request.new(activity_ref).response
    end

    def allow_activity(activity_ref, role_ref)
      AllowActivity::Request.new(activity_ref, role_ref).response
    end

    def disallow_activity(activity_ref, role_ref)
      DisallowActivity::Request.new(activity_ref, role_ref).response
    end

    def check_authorization(activity_ref, role_refs)
      CheckAuthorization::Request.new(activity_ref, role_refs).response
    end

    def list_activities_permissions
      ListActivitiesPermissions::Request.new.response
    end
  end
end