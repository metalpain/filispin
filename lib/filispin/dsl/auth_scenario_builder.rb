module Filispin
  class AuthScenarioBuilder < ScenarioBuilder

    def build
      AuthScenario.new @name, @operations, @params
    end

  end
end