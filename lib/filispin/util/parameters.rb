module Filispin
  module Parameters

    def process(parameters)
      if parameters.is_a? Proc
        parameters.call
      else
        parameters
      end
    end

    def merge_parameters(global, local)
      global.merge process(local)
    end

  end
end