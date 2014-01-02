module Filispin
  class LoadTestRunner
    attr_reader :config

    def initialize(config)
      @config  = config
    end

    def run
      context = {}

      context[:options] = @config.options

      results = Results.new
      context[:results] = results

      progress = Progress.new results, context
      progress.start_report

      users = context[:options][:users]
      @config.scenarios.each do |scenario|
        run_scenario scenario, users, context
      end

      progress.finish_report
      #results.print
    end


    protected

    def run_scenario(scenario, users, context)

      scenario_context = {}
      scenario_context[:options] = context[:options]
      scenario_context[:params] = {} # TODO fill global parameters

      results = ScenarioResults.new scenario, users
      context[:results] << results
      scenario_context[:results] = results

      results.start

      threads = []
      users.times do
        thread = Thread.new do
          scenario.run scenario_context
        end
        threads << thread
      end

      threads.each { |t| t.join }

      results.finish
    end
  end


end

