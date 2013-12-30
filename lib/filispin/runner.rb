module Filispin
  class Runner
    attr_reader :config

    def initialize(config)
      @config  = config
    end

    def run

      context = {}

      context[:options] = @config.options

      results = Results.new
      context[:results] = results

      @config.sessions.each do |session|
        session.run context
      end

      results.print
    end
  end
end

