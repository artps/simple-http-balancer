module Proxy
  module Processor
    class Base
      def initialize(app, *args)
        @app = app

        args = args || []

        configure(*args)
      end
  
      def configure(*args)
      end
  
      def call(env)
        pre(env)
        @app.call(env)
        post(env)
      end
  
      def pre(env)
      end
  
      def post(env)
      end
    end
  end
end
