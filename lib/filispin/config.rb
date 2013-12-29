require 'docile'

module Filispin
  class Config
    attr_reader :sessions

    def initialize
      @sessions = []
    end

    def session(name = nil, &block)
      @sessions << Docile.dsl_eval(SessionBuilder.new(name), &block).build
    end

    def self.load(sessions)

      config = Config.new

      sessions.each do |file|
        config.instance_eval(File.read(file)) if File.exist?(file)
      end

      config
    end

  end


end