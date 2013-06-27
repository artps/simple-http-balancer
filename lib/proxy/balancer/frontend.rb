module Proxy
  module Balancer
    class Frontend < EM::Connection
      def initialize
        @managers = []
      end

      def receive_data(data)
        @managers.each do |manager|
          manager.processors.call(data)
          manager.backend.send_data(data)
        end
      end

      def bind_manager(manager)
        @managers << manager.bind(self)
      end

      def unbind_manager(manager)
        @managers.delete(manager)
        if @managers.empty?
          close_connection_after_writing
        end
      end

      def unbind
        @managers.each do |manager|
          manager.unbind
        end
      end
    end
  end
end
