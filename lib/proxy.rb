require 'eventmachine'

module Proxy

  def self.config(&block)
    Proxy::DSL::Configurator.config(&block)
  end

end

require 'proxy/processor'
require 'proxy/dsl'
require 'proxy/balancer'
require 'proxy/manager'
