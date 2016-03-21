module ActivityPermissionEngine
  module Framework
    module Request
      def self.included(base_class)
        base_class.class_eval do
          private
          def perform
            self.class.parent.new(self).call
          end
        end
      end

      def response
        perform
      end
    end
  end
end