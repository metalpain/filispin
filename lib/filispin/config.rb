require 'docile'

module Filispin
  class Config
    attr_reader :scenarios

    def initialize
      @scenarios = []
    end

    def scenario(&block)
      @scenarios << Docile.dsl_eval(ScenarioBuilder.new, &block).build
    end

    def self.load(scenarios)

      config = Config.new

      scenarios.each do |file|
        config.instance_eval(File.read(file)) if File.exist?(file)
      end

      config
    end

  end


end