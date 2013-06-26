module Proxy
  module Manager
    class Applications
      def initialize(options)
        @options = options
      end

      def run
        applications.each do |app|
          app.run
        end
      end

      def applications
        @applications ||= @options.map do |app_name, options|
          Application.new(app_name, options)
        end
      end
    end
  end
end
