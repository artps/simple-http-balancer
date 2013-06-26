module Proxy
  module Manager
    class Backend

      attr_reader :backend

      def initialize(options)
        @options = options
        @backend = nil
      end

      def host
        @options[:host]
      end

      def port
        @options[:port]
      end

      def bind(frontend)
        self.tap do |manager|
          @backend = EM::bind_connect(
            nil, nil, host, port,
            Balancer::Backend, frontend, self
          ) do |backend|
            backend.proxy_incoming_to(frontend, 10240)
            frontend.proxy_incoming_to(backend, 10240)
          end
        end
      end

      def unbind
        @backend.close_connection
      end
    end
  end
end
