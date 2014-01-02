module Filispin
  class ScenarioBuilder < BlockBuilder

    def initialize(name)
      super()
      @name = name
    end

    def auth(&block)
      @operations << Docile.dsl_eval(OnceBlockBuilder.new, &block).build
    end

    def build
      Scenario.new @name, @operations, @params
    end

  end
end