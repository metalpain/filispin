module Filispin
  class BlockBuilder

    def initialize
      @operations = []
      @params = {}
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

    def params(params = nil, &block)
      @params = params || block
    end

    def build
      Block.new @operations, @params
    end

  end
end