require 'mechanize'

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

      local_context = {
          results: context[:results],
          options: context[:options],
          params: merge_parameters(context[:params], @params),
          browser: Mechanize.new
      }

      iterations = context[:options][:iterations]
      iterations.times do |iteration|
        run_iteration iteration, local_context
      end

    end

    protected

    def run_iteration(iteration, context)
      context[:iteration] = iteration
      @operations.each do |operation|
        operation.run context
      end
    end
  end
end