module ActivityPermissionEngine
  class ActivitiesRegistry
    def initialize(activities)
      @activities = activities
    end

    def all
      activities
    end

    def add(activity_refs)
      activities << activity_refs
      activities.uniq!
      true
    end

    private
    attr_accessor(:activities)
  end
end