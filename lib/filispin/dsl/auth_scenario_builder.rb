module Filispin
  class AuthScenarioBuilder < ScenarioBuilder

    def build
      AuthScenario.new @name, @operations
    end

  end
end