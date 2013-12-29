module Filispin
  class Runner
    attr_reader :config

    def initialize(config)
      @config  = config
    end

    def run

      context = {}

      # TODO fill context with configuration options

      @config.sessions.each do |session|
        session.run context
      end

    end
  end
end

