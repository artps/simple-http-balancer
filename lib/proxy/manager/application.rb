module Proxy
  module Manager
    class Application
      def initialize(config)
        @config = config
      end

      def run
        EM::start_server(@config.listen, @config.port, Balancer::Frontend) do |frontend|
          frontend.bind_manager(backends.vacant)
        end
      end

      def backends
        @backends ||= Backends.new(@config.backends)
      end
    end
  end
end
