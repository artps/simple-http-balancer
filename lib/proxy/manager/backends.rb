module Proxy
  module Manager
    class Backends
      def initialize(options)
        @options = options
      end

      def backends
        @backends ||= @options.map do |options|
          Backend.new(options)
        end
      end
 
      def vacant
        # TODO: Add balancing strategies
        backends.last
      end
    end
  end
end
