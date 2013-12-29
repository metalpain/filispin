module Filispin
  class ScenarioBuilder

    def initialize
      @operations = []
    end

    def get(url)
      @operations << Request.new(:get, url)
    end

    def build
      Scenario.new @operations
    end

  end
end