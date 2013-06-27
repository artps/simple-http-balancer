module Proxy
  module Processor
    class Chain

      def initialize(stack)
        @stack = stack
      end

      def call(env)
        chain.call(env)
      end

      private

      def chain
        @stack.reverse.inject(->(env){ }) do |next_processor, current_processor|
          klass, args = current_processor
          args ||= []

          klass.new(next_processor, *args)
        end
      end
    end
  end
end
