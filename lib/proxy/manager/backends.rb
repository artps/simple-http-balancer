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
        backends.sort_by { |backend| backend.connection_counter.value }.first
      end
    end
  end
end
