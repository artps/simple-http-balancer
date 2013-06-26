module Proxy
  module Manager
    class Counter

      attr_reader :value

      def initialize
        @value = 0
      end

      def up
        @value += 1
      end

      def down
        @value -= 1
      end
    end
  end
end
