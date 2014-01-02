require 'docile'

module Filispin
  class Config
    attr_reader :options, :scenarios

    def initialize
      @scenarios = []
    end

    def configuration(&block)
      @options = Docile.dsl_eval(GlobalConfig.new, &block).options
    end

    def scenario(name, &block)
      @scenarios << Docile.dsl_eval(ScenarioBuilder.new(name), &block).build
    end

    def self.load(files)

      config = Config.new

      files.each do |file|
        config.instance_eval(File.read(file)) if File.exist?(file)
      end

      config
    end

  end


end