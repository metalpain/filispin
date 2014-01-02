module Filispin
  class Runner
    attr_reader :config

    def initialize(config)
      @config  = config
    end

    def run_stress_test
      with_context do |context|
        results = context[:results]
        @config.scenarios.each do |scenario|
          low = 2
          high = nil

          begin
            users = high ? (high + low) / 2 : low * 2
            context[:options][:users] = users
            scenario.run context

            stats = results.current_scenario
            acceptable = stats.errors == 0 && stats.mean < 2.5 && stats.max < 10
            if acceptable
              low = users
            else
              high = users
            end
          end while !high || (high - low > 1)
        end
      end
    end

    def run_load_test
      with_context do |context|
        @config.scenarios.each do |scenario|
          scenario.run context
        end
      end
    end

    protected

    def with_context(&block)
      context = {}
      context[:options] = @config.options

      results = Results.new
      context[:results] = results

      progress = Progress.new results, context
      progress.start_report

      yield context

      progress.finish_report
    end


  end
end