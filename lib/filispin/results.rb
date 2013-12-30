module Filispin

  class Results
    attr_reader :session_results

    def initialize
      @session_results = []
    end

    def <<(session_results)
      @session_results << session_results
    end

    def print
      require 'terminal-table'

      table = Terminal::Table.new do |t|
        t.headings = ['Session', 'Scenario', '# Req.', 'Max.', 'Min.', 'Avg.', 'Median', 'Total', 'Throughput']
        @session_results.each do |session|
          t.add_row [session.name, '',
                     session.number_of_requests,
                     req_time(session.max),
                     req_time(session.min),
                     req_time(session.mean),
                     req_time(session.median),
                     sprintf('%0.3f s.', session.duration),
                     sprintf('%0.2f req/s.', session.throughput)]

          session.scenario_results.values.each do |scenario|
            t.add_row ['', scenario.name,
                       scenario.number_of_requests,
                       req_time(scenario.max),
                       req_time(scenario.min),
                       req_time(scenario.mean),
                       req_time(scenario.median),
                       '-', '-']
          end

          t << :separator
        end
      end

      puts table
    end

    protected

    def req_time(segs)
      ms = segs * 1000
      if ms > 500
        sprintf "\033[31m%f ms.\033[0m", ms
      else
        sprintf '%f ms.', ms
      end
    end

    def throughput(req_per_sec)
      sprintf '%0.2f req/s.', req_per_sec
    end

  end

  class SessionResults
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
      @duration = Time.now.to_f - @start.to_f
    end

    def duration
      @duration
    end

    def mean
      response_times.reduce(:+) / response_times.size
    end

    def median
      sorted = response_times.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    def max
      response_times.max
    end

    def min
      response_times.min
    end

    def number_of_requests
      response_times.size
    end

    def throughput
      number_of_requests.to_f / @duration
    end

    def response_times
      @scenario_results.values.map(&:response_times).flatten
    end
  end

  class ScenarioResults

    attr_reader :name, :response_times

    def initialize(name)
      @name = name
      @response_times = []
      @mutex = Mutex.new
    end

    def add(method, uri, time, page = nil)
      @mutex.synchronize { @response_times << time }
    end

    def mean
      @response_times.reduce(:+) / @response_times.size
    end

    def median
      sorted = @response_times.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    def max
      @response_times.max
    end

    def min
      @response_times.min
    end

    def number_of_requests
      @response_times.size
    end
  end
end