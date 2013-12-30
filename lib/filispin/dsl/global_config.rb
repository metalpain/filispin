module Filispin
  class GlobalConfig
    def initialize
      @options = {}
    end

    def host(host)
      @options[:host] = host
    end

    def log_requests(log_requests)
      @options[:log_requests] = log_requests
    end

    def options
      @options
    end

  end
end