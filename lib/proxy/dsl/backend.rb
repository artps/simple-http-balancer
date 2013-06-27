module Proxy
  module DSL

    class Backend
      def initialize(&block)
        @host = nil
        @port = nil
  
        instance_eval(&block)
      end
  
      def host(value = nil)
        @host ||= value
      end
  
      def port(value = nil)
        @port ||= value
      end
    end

  end
end
