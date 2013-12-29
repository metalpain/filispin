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
      @operations.each do |operation|
        operation.run context
      end
    end

  end
end