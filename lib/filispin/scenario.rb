module Filispin
  class Scenario

    attr_reader :name, :operations

    def initialize(name, operations)
      @name = name
      @operations = operations
    end

    def run(context)
      puts "Running #{name} for it #{context[:iteration]} of user #{context[:user]}\n"

      # TODO set scenario variables
      local_context = {}
      local_context[:results] = context[:results].scenario_results[@name]
      local_context[:browser] = context[:browser]

      @operations.each do |operation|
        operation.run local_context
      end
    end

  end
end