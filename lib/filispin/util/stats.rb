module Filispin
  module Stats


    def mean
      return nil if response_times.empty?
      response_times.reduce(:+) / number_of_requests
    end

    def median
      return nil if response_times.empty?
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
  end
end