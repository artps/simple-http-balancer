module Proxy
  module Manager
    class Backend

      attr_reader :backend
      attr_reader :connection_counter

      def initialize(options)
        @options = options
        @connection_counter = Proxy::Manager::Counter.new
        @backend = nil
      end

      def bind(frontend)
        self.tap do |manager|
          @backend = EM::bind_connect(
            nil, nil, @options.host, @options.port,
            Balancer::Backend, frontend, self
          ) do |backend|
            backend.proxy_incoming_to(frontend, 10240)
            frontend.proxy_incoming_to(backend, 10240)
            connection_counter.up
          end
        end
      end

      def unbind
        backend.close_connection
        connection_counter.down
      end
    end
  end
end
