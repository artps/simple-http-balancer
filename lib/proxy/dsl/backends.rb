module Proxy
  module DSL

    class Backends
      include Enumerable
  
      def initialize(&block)
        @backends = []
  
        instance_eval(&block)
      end
  
      def backend(&block)
        @backends << Backend.new(&block)
      end
  
      def each(&block)
        @backends.each(&block)
      end
    end

  end
end
