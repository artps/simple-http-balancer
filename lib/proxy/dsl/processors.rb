module Proxy
  module DSL

    class Processors
      def initialize(&block)
        @builder = Processor::Builder.new
  
        instance_eval(&block)
      end
  
      def use(klass, *args)
        @builder.use(klass, args)
      end
  
      def call(env)
        @builder.call(env)
      end

    end

  end
end
