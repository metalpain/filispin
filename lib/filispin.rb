require 'filispin/rails/filispin-rails'


module Filispin
  autoload :AuthScenario, File.dirname(__FILE__) + '/filispin/auth_scenario'
  autoload :Config, File.dirname(__FILE__) + '/filispin/config'
  autoload :Request, File.dirname(__FILE__) + '/filispin/request'
  autoload :Results, File.dirname(__FILE__) + '/filispin/results'
  autoload :Runner, File.dirname(__FILE__) + '/filispin/runner'
  autoload :Scenario, File.dirname(__FILE__) + '/filispin/scenario'
  autoload :Session, File.dirname(__FILE__) + '/filispin/session'
  autoload :Timer, File.dirname(__FILE__) + '/filispin/timer'
  autoload :AuthScenarioBuilder, File.dirname(__FILE__) + '/filispin/dsl/auth_scenario_builder'
  autoload :GlobalConfig, File.dirname(__FILE__) + '/filispin/dsl/global_config'
  autoload :ScenarioBuilder, File.dirname(__FILE__) + '/filispin/dsl/scenario_builder'
  autoload :SessionBuilder, File.dirname(__FILE__) + '/filispin/dsl/session_builder'


  def self.run(files)
    config = Config.load files
    Runner.new(config).run
  end

end
