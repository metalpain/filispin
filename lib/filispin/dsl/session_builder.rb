module Filispin
  class SessionBuilder

    def initialize(name = nil)
      @name = name
      @scenarios = []
      @users = 1
      @iterations = 1
    end

    def users(users)
      @users = users
    end

    def iterations(iterations)
      @iterations = iterations
    end

    def scenario(name = nil, &block)
      if block
        @scenarios << Docile.dsl_eval(ScenarioBuilder.new(name), &block).build
      else
        # TODO use already defined scenario
        raise 'unsupported'
      end
    end

    def build
      Session.new @name, @users, @iterations, @scenarios
    end

  end
end