module Filispin

  class ThinkFor

    def initialize(seconds)
      @seconds = seconds
    end

    def run(context)
      sleep(@seconds)
    end
  end
end