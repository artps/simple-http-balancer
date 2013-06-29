simple-http-balancer
====================

This is really simple pure-ruby HTTP (not only) load-balancer. Look into proxy.rb for usage example.

Self-contained solutions like haproxy are great for many HTTP load-balancing needs. However, sometimes you really want increased programmatic control over the balancing (for example, if you wanted to have a dynamic set of allowed backends, or if you wanted to log where each request is routed within your main application).

Installation & Running
====================

```bash
$ git clone https://github.com/arsemyonov/simple-http-balancer.git
$ cd simple-http-balancer
$ bundle
$ vim ./config.rb
$ bundle exec ruby proxy.rb
```

Configuration
====================

You can configure this proxy to using multiple `hostnames:ports` via config.rb. See example below:

```ruby
Proxy.config {

  # nginx-style syntax
  
  server {
    listen '0.0.0.0'
    port 8000
    
    backends {
      backend {
        host '127.0.0.1'
        port 3000
      }
      backend {
        host '127.0.0.1'
        port 3001
      }
      
      processors {
        use SomeProcessor, argument
      }
    }
  }
  
  server {
    listen '0.0.0.0'
    port 8001
    
    backends {
      backend {
        listen '127.0.0.1'
        port 3002
      }
    }
  }

}
```

Also, you can describe you own processor/middleware between requests and responses, for example processor for sending some alert-info:

```ruby
class Alert < Proxy::Processor::Base
  def configure(backend)
    @backend = backend
  end

  def pre(env)
    puts env
  end

  def post(env)
    puts env
  end
end
```

```ruby
server {
  processor {
    use Alert, :email
    use Alert, :sms
  }
}
```
