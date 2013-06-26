require 'rubygems'
require 'bundler'

Bundler.require(:default)

$: << File.join(File.dirname(__FILE__), 'lib')

require 'proxy'
require 'yaml'

class HttpProxy
  class << self

    def run(options)
      EM.epoll
      EM.run do
        trap('TERM') { stop }
        trap('INT')  { stop }

        Proxy::Manager::Applications.new(options).run
      end
    end

    def stop
      EM.stop
    end

  end
end

if __FILE__ == $0
  options = YAML.load_file('settings.yml')
  HttpProxy.run(options)
end
