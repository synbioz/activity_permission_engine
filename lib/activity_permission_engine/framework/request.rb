module ActivityPermissionEngine
  module Framework
    module Request
      def response
        perform
      end

      private
      def perform
        self.class.name.split('::').reverse.drop(1).reverse.inject(Object) do |nesting, name|
          nesting.const_get(name)
        end.new(self).call
      end
    end
  end
end