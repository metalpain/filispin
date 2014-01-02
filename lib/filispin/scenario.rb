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
      users = context[:options][:users]

      scenario_context = {}
      scenario_context[:options] = context[:options]
      scenario_context[:params] = {} # TODO fill global parameters

      results = ScenarioResults.new name, users
      context[:results] << results
      scenario_context[:results] = results

      results.start

      threads = []
      users.times do
        thread = Thread.new do
          run_session scenario_context
        end
        threads << thread
      end

      threads.each { |t| t.join }

      results.finish
    end

    protected

    def run_session(context)

      session_context = {
          results: context[:results],
          options: context[:options],
          params: merge_parameters(context[:params], @params),
          browser: Mechanize.new
      }

      iterations = context[:options][:iterations]
      iterations.times do |iteration|
        run_iteration iteration, session_context
      end

    end

    def run_iteration(iteration, context)
      context[:iteration] = iteration
      @operations.each do |operation|
        operation.run context
      end
    end
  end
end