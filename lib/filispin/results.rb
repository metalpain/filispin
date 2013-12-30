module Filispin

  class Results
    attr_reader :session_results

    def initialize
      @session_results = []
    end

    def <<(session_results)
      @session_results << session_results
    end

  end

  class SessionResults
    include Stats

    attr_reader :name, :scenario_results

    def initialize(name)
      @name = name
      @scenario_results = {}
    end

    def <<(scenario_results)
      @scenario_results[scenario_results.name] = scenario_results
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

    def response_times
      @scenario_results.values.map(&:response_times).flatten
    end

  end

  class ScenarioResults
    include Stats

    attr_reader :name, :response_times

    def initialize(name)
      @name = name
      @response_times = []
      @mutex = Mutex.new
    end

    def add(method, uri, time, page = nil)
      @mutex.synchronize { @response_times << time }
    end

  end
end