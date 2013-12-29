require 'filispin/rails/filispin-rails'


module Filispin
  autoload :Config, File.dirname(__FILE__) + '/filispin/config'
  autoload :Request, File.dirname(__FILE__) + '/filispin/request'
  autoload :Results, File.dirname(__FILE__) + '/filispin/results'
  autoload :Runner, File.dirname(__FILE__) + '/filispin/runner'
  autoload :Scenario, File.dirname(__FILE__) + '/filispin/scenario'
  autoload :Session, File.dirname(__FILE__) + '/filispin/session'
  autoload :Timer, File.dirname(__FILE__) + '/filispin/timer'
  autoload :ScenarioBuilder, File.dirname(__FILE__) + '/filispin/dsl/scenario_builder'
  autoload :SessionBuilder, File.dirname(__FILE__) + '/filispin/dsl/session_builder'


  def self.run(sessions)
    config = Config.load sessions
    Runner.new(config).run
  end

end
