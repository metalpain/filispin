module Filispin
  class Progress
    include Format

    def initialize(results, context)
      @results = results
      @fast_response = context[:options][:response_threshold][:fast]
      @slow_response = context[:options][:response_threshold][:slow]
    end

    def start_report
      @printer = Thread.new { continuous_print }
    end

    def finish_report
      @printer.terminate
      @printer.join
      print @results.current_scenario
      printf "\n"
    end

    protected

    def continuous_print
      printf bold(invert("%-20.20s%10.10s%12.12s%8.8s%8.8s%12.12s%12.12s%12.12s%12.12s%12.12s\n")),
             'scenario', 'users', 'time', 'req', 'err', 'thr', 'max', 'min', 'avg', 'median'

      last = @results.current_scenario
      while true
        current = @results.current_scenario
        if last != current
          print last
          printf "\n"
          last = current
        end

        print current
        STDOUT.flush
        sleep 1.5
      end
    end

    def print(results)
      return unless results

      printf "\r"
      printf '%-20.20s', results.name
      printf '%10d', results.users
      printf '%9d s.', results.elapsed
      printf '%8d', results.number_of_requests
      printf '%8d', results.errors
      printf '%8.2f r/s', results.throughput
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