module Filispin
  class Scenario
    include Parameters

    attr_reader :name, :operations

    def initialize(name, operations, params)
      @name = name
      @operations = operations
      @params = params
    end

    def run(context)

      # TODO set scenario variables
      local_context = {
        results: context[:results].scenario_results[@name],
        browser: context[:browser],
        options: context[:options],
        params: merge_parameters(context[:params], @params)
      }

      @operations.each do |operation|
        operation.run local_context
      end
    end

  end
end