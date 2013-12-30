require 'docile'

module Filispin
  class Config
    attr_reader :options, :sessions

    def initialize
      @sessions = []
    end

    def configuration(&block)
      @options = Docile.dsl_eval(GlobalConfig.new, &block).options
    end

    def session(name, &block)
      @sessions << Docile.dsl_eval(SessionBuilder.new(name), &block).build
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