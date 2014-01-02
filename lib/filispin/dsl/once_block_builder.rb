module Filispin
  class OnceBlockBuilder < BlockBuilder

    def build
      OnceBlock.new @operations, @params
    end

  end
end