require 'singleton'

module Proxy
  module DSL

    class Configurator
      include Singleton

      class << self
        def config(&block)
          if block_given?
            instance.instance_eval(&block)
          else
            instance
          end
        end
      end
  
      attr_reader :servers
  
      def initialize
        @servers = []
      end
  
      def server(&block)
        @servers << Server.new(&block)
      end
    end

  end
end
