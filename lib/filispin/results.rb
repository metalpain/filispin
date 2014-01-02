module Filispin

  class Results
    attr_reader :scenario_results

    def initialize
      @scenario_results = []
    end

    def <<(scenario_results)
      @scenario_results << scenario_results
    end

    def current_scenario
      @scenario_results.last
    end

  end

  class ScenarioResults
    include Stats

    attr_reader :name, :users, :response_times, :errors

    def initialize(scenario, users)
      @name = scenario.name
      @users = users
      @response_times = []
      @errors = 0
      @mutex = Mutex.new
    end

    def start
      @start = Time.now
    end

    def finish
      @finish = Time.now
    end

    def elapsed
      if @finish
        @finish.to_f - @start.to_f
      else
        Time.now.to_f - @start.to_f
      end
    end

    def throughput
      number_of_requests.to_f / elapsed
    end

    def success(method, uri, time, page = nil)
      @mutex.synchronize { @response_times << time }
    end

    def error(method, uri)
      @mutex.synchronize { @errors += 1 }
    end

  end
end