module Proxy
  module DSL

    class Server
      def initialize(&block)
        @listen = nil
        @port   = nil
  
        instance_eval(&block)
      end
  
      def listen(value = nil)
        @listen ||= value
      end
  
      def port(value = nil)
        @port ||= value
      end
  
      def backends(&block)
        if block_given?
          @backends = Backends.new(&block)
        else
          @backends
        end
      end
  
      def processors(&block)
        if block_given?
          @processors = Processors.new(&block)
        else
          @processors
        end
      end
    end

  end
end
