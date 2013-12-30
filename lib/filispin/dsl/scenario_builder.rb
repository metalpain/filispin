module Filispin
  class ScenarioBuilder

    def initialize(name)
      @operations = []
      @name = name
    end

    def get(url, &block)
      @operations << Request.new(:get, url,  block || {})
    end

    def post(url, params = nil, &block)
      @operations << Request.new(:post, url, params || block)
    end

    def build
      Scenario.new @name, @operations
    end

  end
end