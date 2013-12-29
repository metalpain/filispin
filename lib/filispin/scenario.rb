module Filispin
  class Scenario

    attr_reader :name, :operations

    def initialize(name, operations)
      @name = name
      @operations = operations
    end

    def run
      puts "Running #{name} for it #{Thread.current[:iteration]} of user #{Thread.current[:user]}\n"
      #@operations.each do |operation|
      #  operation.run iteration, results
      #end
    end

  end
end