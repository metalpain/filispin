module Filispin
  class Scenario

    attr_reader :name, :operations

    def initialize(name, operations)
      @name = name
      @operations = operations
    end

    def run(context)

      # TODO set scenario variables
      local_context = {}
      local_context[:results] = context[:results].scenario_results[@name]
      local_context[:browser] = context[:browser]
      local_context[:options] = context[:options]

      @operations.each do |operation|
        operation.run local_context
      end
    end

  end
end