module Filispin
  class Progress
    include Format

    def initialize(results, context)
      @results = results
      @context = context

      @fast_response = context[:options][:response_threshold][:fast]
      @slow_response = context[:options][:response_threshold][:slow]
    end

    def start_report
      @printer = Thread.new { continuous_print }
    end

    def finish_report
      @printer.terminate
      @printer.join
      print
    end

    protected

    def continuous_print
      while true
        print
        printf "\e[%dF", (5 + @results.scenario_results.size)
        STDOUT.flush
        sleep 1.5
      end
    end

    def print
      printf bold(invert(" %-79.79s\n")), @results.name
      printf underline("%-20.20s%12.12s%12.12s%12.12s%12.12s%12.12s\n"), 'scenario', '# req', 'max', 'min', 'avg', 'median'
      @results.scenario_results.values.each do |scenario|
        printf '%-20.20s', scenario.name
        print_results_line scenario
        printf "\n"
      end
      printf '%-20.20s',  'Total'
      print_results_line @results
      printf "\n"

      printf "Elapsed: %3d s. | ", @results.elapsed
      printf "Req: # %5d | ", @results.number_of_requests
      printf "Throughput: %.2f req./s.", @results.throughput
      printf "\n"
      printf "\n"
    end

    def print_results_line(results)
      printf '%12d', results.number_of_requests
      print_req_time results.max
      print_req_time results.min
      print_req_time results.mean
      print_req_time results.median
    end

    def print_req_time(segs)
      if segs
        ms = segs * 1000
        if segs < @fast_response
          format = green('%8.0f ms.')
        elsif segs < @slow_response
          format = yellow('%8.0f ms.')
        else
          format = red('%8.0f ms.')
        end

        printf format, ms
      else
        printf('%12s', '-')
      end
    end


  end

end