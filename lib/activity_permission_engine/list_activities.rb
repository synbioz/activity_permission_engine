module ActivityPermissionEngine
  class ListActivities
    def initialize(request, activities_registry = ActivityPermissionEngine.configuration.activities_registry)
      @request = request
      @activities_registry = activities_registry
    end

    def call
      Response.new(activities_registry.all)
    end

    private
    attr_reader(:activities_registry)

    class Request
      include Framework::Request
    end

    class Response
      def initialize(activity_refs)
        @activity_refs = activity_refs
      end

      attr_reader(:activity_refs)
    end
  end
end