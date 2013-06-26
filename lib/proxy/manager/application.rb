module Proxy
  module Manager
    class Application
      def initialize(name, options)
        @name = name
        @options = options
      end

      def run
        EM::start_server(host, port, Balancer::Frontend) do |frontend|
          frontend.bind_manager(backends.vacant)
        end
      end

      def host
        @options[:host]
      end

      def port
        @options[:port]
      end

      def backends
        @backends ||= Backends.new(@options[:backends])
      end
    end
  end
end
