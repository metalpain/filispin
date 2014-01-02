module Filispin
  class Block
    include Parameters

    attr_reader :operations

    def initialize(operations, params)
      @operations = operations
      @params = params
    end

    def run(context)

      local_context = {
          results: context[:results],
          browser: context[:browser],
          options: context[:options],
          params: merge_parameters(context[:params], @params)
      }

      @operations.each do |operation|
        operation.run local_context
      end
    end

  end
end