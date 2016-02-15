module ActivityPermissionEngine
  module Framework
    module Request

      def response
        perform
      end

      private
      def perform
        Object.const_get(self.class.name.split('::').reverse.drop(1).reverse.join('::')).new(self).call
      end
    end
  end
end