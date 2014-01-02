module Filispin
  class OnceBlock < Block

    def run(context)
      if context[:iteration] == 0
        super
      end
    end
  end
end