module Proxy
  module Manager
    class Applications
      def initialize
        @config = Proxy::DSL::Configurator.config
      end

      def run
        applications.each do |app|
          app.run
        end
      end

      def applications
        @applications ||= @config.servers.map do |config|
          Application.new(config)
        end
      end
    end
  end
end
