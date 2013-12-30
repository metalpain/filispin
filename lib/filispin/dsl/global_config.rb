module Filispin
  class GlobalConfig
    def initialize
      @options = {
          host: 'http://localhost:3000',
          think_time: 1,
          response_threshold: {fast: 0.5, slow: 2},
          load: 1,
      }
    end

    def host(host)
      @options[:host] = host
    end

    def think_time(think_time)
      @options[:think_time] = think_time
    end

    def response_threshold(fast, slow)
      @options[:response_threshold] = {fast: fast, slow: slow}
    end

    def load(load)
      @options[:load] = load
    end

    def options
      @options
    end

  end
end