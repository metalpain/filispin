module Filispin
  class AuthScenario < Scenario

    def run(context)
      if context[:iteration] == 0
        super
      end
    end
  end
end