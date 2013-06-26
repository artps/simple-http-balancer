module Proxy
  module Balancer
    class Backend < EM::Connection

      attr_reader :manager

      def initialize(frontend, manager)
        @frontend  = frontend
        @manager   = manager
        @connected = EM::DefaultDeferrable.new
      end

      def connection_completed
        @connected.succeed
      end

      def send(data)
        @connected.callback do
          send_data(data)
        end
      end

      def receive_data(data)
        @frontend.send_data(data)
      end

      def unbind
        @frontend.unbind_manager(manager)
      end
    end
  end
end
