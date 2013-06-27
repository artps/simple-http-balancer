module Proxy
  module Processor
    class Builder
      def initialize
        @stack = []
      end
  
      def use(klass, *args)
        @stack << [klass, args]
      end
  
      def call(env = nil)
        app.call(env)
      end
  
      def app
        Chain.new(@stack.dup)
      end
    end
  end
end
