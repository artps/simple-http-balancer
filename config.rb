class Alert < Proxy::Processor::Base
  def configure(backend)
    @backend = backend
  end

  def pre(env)
    # Add wanted logic
    puts env
  end

  def post(env)
    # Add wanted logic
    puts env
  end
end


Proxy.config do
  server {
    listen '127.0.0.1'
    port   8000

    backends {
      backend {
        host '127.0.0.1'
        port 3000
      }
      backend {
        host '127.0.0.1'
        port 3001
      }
    }

    processors {
      use Alert, :email
      use Alert, :sms
    }
  }
end

# Proxy.config.servers.each do |server|
#   puts server.listen
#   puts server.port
#
#   puts 'Backends: '
#   server.backends.each do |backend|
#     puts backend.host
#     puts backend.port
#   end
#
#   puts 'Processors: '
#   server.processors.call(:foo)
# end
