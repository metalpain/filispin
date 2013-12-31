module Filispin
  class SessionBuilder

    def initialize(name = nil)
      @name = name
      @scenarios = []
      @users = 1
      @iterations = 1
      @params = {}
    end

    def users(users)
      @users = users
    end

    def iterations(iterations)
      @iterations = iterations
    end

    def scenario(name, &block)
      if block
        @scenarios << Docile.dsl_eval(ScenarioBuilder.new(name), &block).build
      else
        # TODO use already defined scenario
        raise 'unsupported'
      end
    end

    def auth(&block)
      if block
        @scenarios << Docile.dsl_eval(AuthScenarioBuilder.new('auth'), &block).build
      else
        # TODO use already defined scenario
        raise 'unsupported'
      end
    end

    def params(params = nil, &block)
      @params = params || block
    end

    def build
      Session.new @name, @users, @iterations, @scenarios, @params
    end

  end
end