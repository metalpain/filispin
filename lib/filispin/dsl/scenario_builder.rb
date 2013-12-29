module Filispin
  class ScenarioBuilder

    def initialize(name = nil)
      @operations = []
      @name = name
    end

    def get(url)
      @operations << Request.new(:get, url)
    end

    def build
      Scenario.new @name, @operations
    end

  end
end