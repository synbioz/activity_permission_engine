module ActivityPermissionEngine
  class RegisterActivity
    def initialize(request, activity_registry)
      @request = request
      @activity_registry = activity_registry
    end

    def call
      Response.new(activity_registry.add(request.activity_ref))
    end

    private
    attr_reader(:request, :activity_registry)

    class Request
      def initialize(activity_ref)
        @activity_ref = activity_ref
      end

      attr_reader(:activity_ref)
    end

    class Response
      def initialize(success)
        @success = success
      end

      def success?
        success
      end

      private
      attr_reader :success
    end
  end
end