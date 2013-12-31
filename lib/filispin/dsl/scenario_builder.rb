module Filispin
  class ScenarioBuilder

    def initialize(name)
      @operations = []
      @name = name
    end

    def think_for(seconds)
      @operations << ThinkFor.new(seconds.to_f)
    end

    def get(url, &block)
      @operations << Request.new(:get, url,  block || {})
    end

    def delete(url, &block)
      @operations << Request.new(:delete, url,  block || {})
    end

    def post(url, params = nil, &block)
      @operations << Request.new(:post, url, params || block)
    end

    def patch(url, params = nil, &block)
      @operations << Request.new(:patch, url, params || block)
    end

    def put(url, params = nil, &block)
      @operations << Request.new(:put, url, params || block)
    end

    def build
      Scenario.new @name, @operations
    end

  end
end