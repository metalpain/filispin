module Filispin
  class Runner
    attr_reader :config

    def initialize(config)
      @config  = config
    end

    def run

      config.sessions.each do |session|
        session.run
      end
    end
  end
end

