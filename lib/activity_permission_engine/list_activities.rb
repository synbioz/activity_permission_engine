module ActivityPermissionEngine
  class ListActivities
    def initialize(activities_registry)
      @activities_registry = activities_registry
    end

    def call
      Response.new(activities_registry.all)
    end

    private
    attr_reader(:activities_registry)

    class Response
      def initialize(activity_refs)
        @activity_refs = activity_refs
      end

      attr_reader(:activity_refs)
    end
  end
end