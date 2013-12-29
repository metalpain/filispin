require 'filispin/rails/filispin-rails'


module Filispin
  autoload :Config, File.dirname(__FILE__) + '/filispin/config'
  autoload :Request, File.dirname(__FILE__) + '/filispin/request'
  autoload :Scenario, File.dirname(__FILE__) + '/filispin/dsl/scenario'
  autoload :ScenarioBuilder, File.dirname(__FILE__) + '/filispin/dsl/scenario_builder'


  def self.run(scenarios)
    config = Config.load scenarios

  end

end
